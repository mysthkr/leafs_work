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
        click_link 'Logout'
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
  
  describe '管理画面のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    before do
      visit tasks_path
    end
    
    context '管理ユーザでログインし管理ページに移動した場合' do
      it '管理ユーザは管理画面にアクセスできること' do
        to_login
        visit admin_users_path
        expect(page).to have_content I18n.t('view.user_list')
      end
    end
    
    context '一般ユーザで管理ページに移動した場合' do
      it '一般ユーザはtasks画面にリダイレクトされること' do
        to_sign_up_sign_in
        visit admin_users_path
        expect(page).to have_content I18n.t('view.task_list')
      end
    end
    
    context '管理ユーザはユーザの新規登録した場合' do
      it 'ユーザ一覧画面で新規登録したユーザが確認できること' do
        create_user_by_admin
        expect(page).to have_content 'test20'
      end
    end
    
    context '管理ユーザはユーザの詳細をクリックした場合' do
      it 'ユーザの詳細画面にアクセスできること' do
        to_login
        visit admin_users_path
        click_link I18n.t('view.task_detail')
        expect(page).to have_content I18n.t('view.email')
      end
    end
    
    context '管理ユーザはユーザの編集をクリックした場合' do
      it '管理ユーザはユーザの編集画面からユーザを編集できること' do
        to_login
        visit admin_users_path
        click_link I18n.t('view.edit_task')
        expect(page).to have_content I18n.t('view.edit_user')
      end
    end
    
    context '管理ユーザはユーザの削除をクリックした場合' do
      it '削除されたユーザがユーザ一覧にて確認できないこと' do
        to_sign_up_sign_in
        click_link 'Logout'
        to_login
        visit admin_users_path
        all('a', :text => I18n.t('view.delete_task'))[1].click
        expect(page).to have_no_content 'test20'
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
  visit tasks_path
  click_link 'Sign up'
  fill_in "Name", with: "test20"
  fill_in "Email", with: "test20@gmail.com"
  fill_in "Password", with: "password"
  fill_in "Password confirmation", with: "password"
  click_button "Create my account"
  visit tasks_path
end

def create_user_by_admin
  to_login
  visit admin_users_path
  click_link I18n.t('view.create_user')
  fill_in "Name", with: "test20"
  fill_in "Email", with: "test20@gmail.com"
  fill_in "Password", with: "password"
  fill_in "Password confirmation", with: "password"
  click_button "Create my account"
end

def current_user
  @current_user ||= User.find_by(id: session[:user_id])
end