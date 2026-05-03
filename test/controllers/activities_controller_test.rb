require "test_helper"

class ActivitiesControllerUnauthenticatedTest < ActionDispatch::IntegrationTest
  test "guest is redirected from activities index" do
    get activities_url
    assert_redirected_to login_path
  end

  test "guest is redirected from root" do
    get root_url
    assert_redirected_to login_path
  end
end

class ActivitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @activity = activities(:one)

    @user = User.create!(
      name: "Test User",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )

    @activity = Activity.create!(
      title: "Running",
      city: "Seattle",
      category: "Test",
      event_date: Date.today,
      user: @user
    )

    post login_path, params: {
      email: @user.email,
      password: "password"
    }
  end

  test "should get index" do
    get activities_url
    assert_response :success
  end

  test "should get new" do
    get new_activity_url
    assert_response :success
  end

  test "should create activity" do
    assert_difference("Activity.count") do
      post activities_url, params: { activity: { category: @activity.category, city: @activity.city, description: @activity.description, event_date: @activity.event_date, location: @activity.location, title: @activity.title } }
    end

    assert_redirected_to activities_path
  end

  test "should show activity" do
    get activity_url(@activity)
    assert_response :success
  end

  test "should get edit" do
    get edit_activity_url(@activity)
    assert_response :success
  end

  test "should update activity" do
    patch activity_url(@activity), params: { activity: { category: @activity.category, city: @activity.city, description: @activity.description, event_date: @activity.event_date, location: @activity.location, title: @activity.title } }
    assert_redirected_to activities_path
  end

  test "should destroy activity" do
    assert_difference("Activity.count", -1) do
      delete activity_url(@activity)
    end

    assert_redirected_to activities_url
  end

  test "cannot edit another user's activity" do
    other = User.create!(
      name: "Other",
      email: "other@example.com",
      password: "password",
      password_confirmation: "password"
    )
    foreign = Activity.create!(
      title: "Theirs",
      city: "NYC",
      category: "X",
      event_date: Date.today,
      user: other
    )

    get edit_activity_url(foreign)
    assert_redirected_to root_path
    follow_redirect!
    assert_match "Not authorized", response.body
  end
end
