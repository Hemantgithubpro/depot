require "application_system_test_case"
require "action_mailbox/test_helper"

class SupportRequestsTest < ApplicationSystemTestCase
  include ActionMailer::TestHelper
  include ActionMailbox::TestHelper

  test "receiving an incoming email and responding to it" do
    customer = "customer@example.com"
    order = orders(:one)
    order.update!(email: customer)

    # 1. Simulate an inbound support email via Action Mailbox
    receive_inbound_email_from_mail \
      to: "support@example.com",
      from: customer,
      subject: "Need help with my book order",
      body: "I would like to know when my order will be delivered."

    # 2. Log in as an administrator
    visit new_session_url
    fill_in "email_address", with: users(:one).email_address
    fill_in "password", with: "password"
    click_button "Sign in"
    assert_current_path store_index_path

    # 3. View the support requests dashboard
    visit support_requests_url

    assert_text "Need help with my book order"
    assert_text customer
    assert_text "Order ##{order.id}"

    # 4. Fill in the rich text response (Trix editor) and submit
    within "li", text: "Need help with my book order" do
      fill_in_rich_text_area "Write a response:", with: "We have shipped your order today!"

      assert_emails 1 do
        click_button "Send Response"
        assert_text "We have shipped your order today!"
      end
    end

    # 5. Verify email delivery
    mail = ActionMailer::Base.deliveries.last
    assert_equal [ customer ], mail.to
    assert_equal "Re: Need help with my book order", mail.subject
    assert_includes mail.body.to_s, "We have shipped your order today!"
  end
end
