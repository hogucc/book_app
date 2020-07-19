# frozen_string_literal: true

require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:alice)
    @book = books(:book1)
  end

  test "visiting the index" do
    visit books_url
    assert_selector "h1", text: "本の一覧"
  end

  test "visiting the show" do
    visit books_url
    click_on "詳細", match: :first

    assert_text "リーダブルコード"
    assert_text "オライリージャパン"
    assert_text "Dustin Boswell"
  end

  test "creating a Book" do
    visit books_url
    click_on "本の登録"

    fill_in "タイトル", with: @book.title
    fill_in "メモ", with: @book.memo
    fill_in "著者", with: @book.author
    assert_difference 'Book.count', 1 do
      click_on "登録する"
    end

    assert_text "本を登録しました"
    assert_text "リーダブルコード"
    assert_text "オライリージャパン"
    assert_text "Dustin Boswell"
  end

  test "updating a Book" do
    visit books_url
    click_on "編集", match: :first
 
    fill_in "タイトル", with: "タイトル：リーダブルコード"
    fill_in "メモ", with: "メモ：オライリージャパン"
    fill_in "著者", with: "著者：Dustin Boswell"
    click_on "更新する"

    assert_text "本を更新しました"
    assert_text "タイトル：リーダブルコード"
    assert_text "メモ：オライリージャパン"
    assert_text "著者：Dustin Boswell"
  end

  test "destroying a Book" do
    visit books_url
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "本を削除しました" 
  end
end
