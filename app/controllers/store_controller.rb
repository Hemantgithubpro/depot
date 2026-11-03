class StoreController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)
  end
end
