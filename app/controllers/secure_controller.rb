# If any controllers need to be secured from non logged in users, have the controller in question inherit this controller.
class Security::SecureController < ApplicationController
  before_filter :authorize
end