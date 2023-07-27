class Admin::DashboardController < Admin::AuthenticationController
  def show
    @category = Category.all
    @product_count = Product.count
  end
end
