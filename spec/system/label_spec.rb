require 'rails_helper'
RSpec.describe 'Label機能', type: :system do
  describe 'Labeling機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:label) { FactoryBot.create(:label) }
    let!(:second_label) { FactoryBot.create(:second_label) }
    
    context 'タスクを新規作成した場合' do
      it 'タスク一覧画面に作成したLabelが表示される' do
        to_login
        visit new_task_path
        fill_in "Task name", with: "test name"
        fill_in "Task detail", with: "test detail"
        check 'Label1'
        click_button I18n.t('helpers.submit.create')
        expect(page).to have_content "Label1"
      end
    end
    
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスク紐づけしたLabelが表示される' do
        to_login
        visit new_task_path
        fill_in "Task name", with: "test name"
        fill_in "Task detail", with: "test detail"
        check 'Label1'
        click_button I18n.t('helpers.submit.create')
        click_link I18n.t('view.detail')
        expect(page).to have_content "Label1"
      end
    end
    
    context 'タスク一覧画面に遷移した場合' do
      it '紐づけたラベルで検索すると特定ラベルに紐づいているタスクが表示される' do
        to_login
        visit new_task_path
        fill_in "Task name", with: "test name"
        fill_in "Task detail", with: "test detail"
        check 'Label1'
        click_button I18n.t('helpers.submit.create')
        
        visit new_task_path
        fill_in "Task name", with: "test name2"
        fill_in "Task detail", with: "test detail2"
        check 'Label2'
        click_button I18n.t('helpers.submit.create')
        
        select 'Label2', from: 'task[label_id]'
        click_button I18n.t('view.search')
        expect(find('table')).to have_no_content "Label1"
        expect(find('table')).to have_content "Label2"
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