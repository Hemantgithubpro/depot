class SupportRequestMailer < ApplicationMailer
  default from: "Sam Ruby <depot@example.com>"

  def respond(support_request)
    @support_request = support_request
    mail to: @support_request.email, subject: "Re: #{@support_request.subject}"
  end
end
