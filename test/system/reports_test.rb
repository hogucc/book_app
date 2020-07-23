# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:alice)
    @report = reports(:report1)
  end

  test "visiting the index" do
    visit reports_url
    assert_selector "h1", text: "日報の一覧"
  end

  test "visiting the show" do
    visit reports_url
    click_on "詳細", match: :first

    assert_text "日報サンプル"
    assert_text "はじめて日報を書いてみました。"
  end

  test "creating a report" do
    visit reports_url
    click_on "日報の登録"

    fill_in "タイトル", with: @report.content
    fill_in "内容", with: @report.title
    assert_difference "Report.count", 1 do
      click_on "登録する"
    end

    assert_text "日報を登録しました"
  end

  test "updating a report" do
    visit reports_url
    click_on "編集", match: :first

    fill_in "タイトル", with: "タイトル：日報サンプル"
    fill_in "内容", with: "内容：はじめて日報を書いてみました。"
    click_on "更新する"

    assert_text "日報を更新しました"
    assert_text "タイトル：日報サンプル"
    assert_text "内容：はじめて日報を書いてみました。"
  end

  test "destroying a report" do
    visit reports_url
    page.accept_confirm do
      click_on "削除", match: :first
    end

    assert_text "日報を削除しました"
  end
end
