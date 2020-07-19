# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  def setup
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
    click_button "フォローする"

    assert has_link?("1フォロワー")
  end

  test "unfollow user" do
    @other = users(:chris)
    visit user_path(@other)
    click_button "フォロー解除"

    assert has_link?("0フォロワー")
  end
end
