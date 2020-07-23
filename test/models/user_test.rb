# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "find_for_github_oauth" do
    auth = OmniAuth::AuthHash.new(
      uid: "1",
      provider: "github",
      info: {
        name: "alice",
        email: "alice@example.com"
      }
    )
    alice = users(:alice)
    auth_user = User.find_for_github_oauth(auth)
    assert alice.uid == auth_user.uid
  end

  test "before_follow" do
    alice = users(:alice)
    bob = users(:bob)
    assert_not alice.following?(bob)
  end

  test "follow" do
    alice = users(:alice)
    bob = users(:bob)

    alice.follow(bob)
    assert alice.following?(bob)
    assert bob.followers.include?(alice)
  end

  test "unfollow" do
    alice = users(:alice)
    bob = users(:bob)

    alice.follow(bob)
    alice.unfollow(bob)
    assert_not alice.following?(bob)
  end
end
