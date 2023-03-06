require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザ新規作成機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    before do
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
        expect(page).to have_content 'Log in'
      end
    end
  end
  
  describe 'セッション機能' do
    let!(:user) { FactoryBot.create(:user, admin: false) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    before do
      visit tasks_path
    end
    
    context 'ログイン画面からログインしユーザページに移動した場合' do
      it '自分の詳細画面(マイページ)に遷移しログインすること' do
        to_login
        visit tasks_path
        click_link 'Profile'
        expect(page).to have_content 'test10'
      end
    end
    
    context '一般ユーザが他人の詳細画面に飛んだ場合' do
      it 'タスク一覧画面に遷移すること' do
        to_login
        visit tasks_path
        id=User.find_by(name: "test10").id
        to_sign_up_sign_in
        visit user_path(id)
        expect(page).to have_content I18n.t('view.task_list')
      end
    end
    
    context 'ログアウトした場合' do
      it 'ログイン画面に遷移すること' do
        to_login
        click_link 'Logout'
        expect(page).to have_content 'Log in'
      end
    end
  end
end

private

def to_login
  visit tasks_path
  fill_in "Email", with: "test10@gmail.com"
  fill_in "Password", with: "password"
  click_button 'Log in'
end

def to_sign_up_sign_in
  click_link 'Logout'
  visit tasks_path
  click_link 'Sign up'
  fill_in "Name", with: "test20"
  fill_in "Email", with: "test20@gmail.com"
  fill_in "Password", with: "password"
  fill_in "Password confirmation", with: "password"
  click_button "Create my account"
  visit tasks_path
end

def current_user
  @current_user ||= User.find_by(id: session[:user_id])
end