require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザ新規作成機能' do
    before do
      【共通の前準備をする】
      visit tasks_path
    end
    context 'ユーザを新規登録した場合' do
      it 'タスク一覧画面に遷移すること' do
        visit new_user_path
        fill_in "Name", with: "test"
        fill_in "Email", with: "test@gmail.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button 'Create my account'
        expect(page).to have_content I18n.t('view.task_list')
      end
    end
    
    context 'ユーザがログインせずタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
      end
    end
    
  end
end