require "test_helper"

class ActivitySignupTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      name: "Host",
      email: "host@example.com",
      password: "password",
      password_confirmation: "password"
    )

    @other = User.create!(
      name: "Guest",
      email: "guest@example.com",
      password: "password",
      password_confirmation: "password"
    )

    @activity = Activity.create!(
      title: "Picnic",
      city: "Seattle",
      category: "Fun",
      event_date: Date.today,
      user: @user
    )
  end

  test "allows a user to sign up once" do
    signup = ActivitySignup.new(activity: @activity, user: @other)

    assert signup.save
    assert_not ActivitySignup.new(activity: @activity, user: @other).valid?
  end
end
