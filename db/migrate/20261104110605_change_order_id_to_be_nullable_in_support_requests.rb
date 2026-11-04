class ChangeOrderIdToBeNullableInSupportRequests < ActiveRecord::Migration[8.1]
  def change
    change_column_null :support_requests, :order_id, true
  end
end
