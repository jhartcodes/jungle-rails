class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_AUTHOR_USERNAME"], password: ENV["ADMIN_AUTHOR_PASSWORD"]

  def show
    @products_count = Product.count
    @categories_count = Category.count
  end
  
end
