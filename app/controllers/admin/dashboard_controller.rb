class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV["HTTP_BASIC_USER"],
                               password: ENV["HTTP_BASIC_PASSWORD"]

  def show
    @products_total = Product.count.inspect
    @categories_total = Category.count.inspect
  end
end
