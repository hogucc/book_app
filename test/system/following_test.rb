# frozen_string_literal: true

require "application_system_test_case"

class FollowingTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:alice)
    @other = users(:tom)
    sign_in @user
  end

  test "following page" do
    visit user_followings_path @user
    assert_not @user.following.empty?

    @user.following.each do |user|
      assert has_link?(user.user_name)
    end
  end

  test "followers page" do
    visit user_followers_path @user
    assert_not @user.followers.empty?

    @user.followers.each do |user|
      assert has_link?(user.user_name)
    end
  end

  test "following user" do
    visit user_path(@other)

    assert_difference "@user.following.count" do
      click_button "フォローする"
      until find_button("commit").value == "フォロー解除"; end
    end

    assert has_link?("1フォロワー")
  end

  test "unfollow user" do
    @other = users(:chris)
    visit user_path(@other)

    assert_difference "@user.following.count", -1 do
      click_button "フォロー解除"
      until find_button("commit").value == "フォローする"; end
    end

    assert has_link?("0フォロワー")
  end
end
