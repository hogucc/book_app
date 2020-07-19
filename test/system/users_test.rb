# frozen_string_literal: true

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:alice)
    sign_in @user
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "ユーザー一覧"
  end

  test "visiting the show" do
    visit books_url
    click_on "プロフィール", match: :first

    assert_text "プロフィール"
  end

  test "update profile" do
    visit user_url(@user)
    click_on "プロフィールの編集", match: :first

    fill_in "ユーザー名", with: "carol"
    fill_in "Eメール", with: "carol@example.com"
    fill_in "郵便番号", with: "111-1111"
    fill_in "住所", with: "東京都中央区日本橋1-1-1"
    fill_in "自己紹介", with: "よろしくお願いします。"
    click_on "更新する"
 
    assert_text "プロフィール"
    assert_text "carol"
    assert_text "carol@example.com"
    assert_text "111-1111"
    assert_text "東京都中央区日本橋1-1-1"
    assert_text "よろしくお願いします。"
  end
end
