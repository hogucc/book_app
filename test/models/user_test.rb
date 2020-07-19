# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  def test_find_for_github_oauth
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

  def test_before_follow
    alice = users(:alice)
    bob = users(:bob)
    assert_not alice.following?(bob)
  end

  def test_follow
    alice = users(:alice)
    bob = users(:bob)

    alice.follow(bob)
    assert alice.following?(bob)
    assert bob.followers.include?(alice)
  end

  def test_unfollow
    alice = users(:alice)
    bob = users(:bob)

    alice.follow(bob)
    alice.unfollow(bob)
    assert_not alice.following?(bob)
  end
end
