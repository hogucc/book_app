# frozen_string_literal: true

require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:alice)
    @book = books(:book1)
    @report = reports(:report1)
    @book_comment = comments(:book_comment)
    @report_comment = comments(:report_comment)
  end

  test "creating a Book Comment" do
    visit book_url(@book)

    fill_in "内容", with: "本にコメントしてみた"
    click_on "コメントする"

    assert_text "コメントしました"
    assert_text "本にコメントしてみた"
  end

  test "creating a Report Comment" do
    visit report_url(@report)

    fill_in "内容", with: "日報にコメントしてみた"
    click_on "コメントする"

    assert_text "コメントしました"
    assert_text "日報にコメントしてみた"
  end

  test "updating a Book Comment" do
    visit book_url(@book)
    
    within(".comment") do
      click_on "編集"
    end

    fill_in "内容", with: "本のコメントを更新" 
    click_on "コメントする"

    assert_text "コメントを更新しました"
    assert_text "本のコメントを更新"
  end

  test "updating a Report Comment" do
    visit report_url(@report)
    
    within(".comment") do
      click_on "編集"
    end

    fill_in "内容", with: "日報のコメントを更新" 
    click_on "コメントする"

    assert_text "コメントを更新しました"
    assert_text "日報のコメントを更新"
  end

  test "destroying a Book Comment" do
    visit book_url(@book) 
    page.accept_confirm do
       within(".comment") do
        click_on "削除"
      end
    end

    assert_text "コメントを削除しました"
  end

  test "destroying a Report Comment" do
    visit report_url(@report) 
    page.accept_confirm do
      within(".comment") do
        click_on "削除"
      end
    end

    assert_text "コメントを削除しました"
  end
end
