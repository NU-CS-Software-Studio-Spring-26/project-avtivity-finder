require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      name: "Test User",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  test "should get login page" do
    get login_path
    assert_response :success
  end

  test "should login with valid credentials" do
    post login_path, params: {
      email: @user.email,
      password: "password"
    }

    assert_redirected_to root_path
    follow_redirect!
    assert_match "Logged in successfully", response.body
  end

  test "should not login with invalid credentials" do
    post login_path, params: {
      email: @user.email,
      password: "wrongpassword"
    }

    assert_response :unprocessable_entity
    assert_match "Invalid email or password", response.body
  end

  test "should not login with unknown email and show generic message" do
    post login_path, params: {
      email: "notregistered@example.com",
      password: "anypassword"
    }

    assert_response :unprocessable_entity
    assert_match "Invalid email or password", response.body
  end

  test "login matches email case-insensitively" do
    post login_path, params: {
      email: @user.email.upcase,
      password: "password"
    }

    assert_redirected_to root_path
  end

  test "should logout successfully" do
    post login_path, params: {
      email: @user.email,
      password: "password"
    }

    delete logout_path

    assert_redirected_to login_path
    follow_redirect!
    assert_match "Logged out successfully", response.body
  end
end
