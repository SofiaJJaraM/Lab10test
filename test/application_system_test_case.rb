require "test_helper"
require "warden/test/helpers"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]
end

# Provide helper to login users in system tests if needed
module SystemTestLoginHelpers
  def login_as_user(user)
    login_as(user, scope: :user)
  end
end

class ActionDispatch::SystemTestCase
  include Warden::Test::Helpers
  include SystemTestLoginHelpers
end
