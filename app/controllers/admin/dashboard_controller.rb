class Admin::DashboardController < Admin::AuthenticationController
  def show
    @category_count = 2
    @product_count = 20
  end
end
