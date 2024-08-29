require 'rails_helper'

RSpec.describe "ログアウト機能", type: :system do
  let(:user) { create(:user) }

  before do
    # テストユーザーでログイン
    sign_in user
  end

  it 'ログアウトに成功し、ログインページにリダイレクトされる' do
    # ルートページにアクセス
    visit root_path

    # ログアウトリンクをクリック
    click_link 'ログアウト'

    # ログインページにリダイレクトされているか確認
    expect(page).to have_content 'ログイン'
  end
end