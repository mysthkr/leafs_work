require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    before do
      visit tasks_path
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "Task name", with: "test name"
        fill_in "Task detail", with: "test detail"
        click_button I18n.t('helpers.submit.create')
        expect(page).to have_content "test name"
        expect(page).to have_content "test detail"
        expect(page).to have_content "ToDo"
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
        FactoryBot.create(:forth_task)
        FactoryBot.create(:fifth_task)
        
        visit tasks_path
        tasks_before = []
        tasks_after = []
        
        tasks_bf = page.all(".task_name")
        tasks_bf.each do |task|
          tasks_before << task['innerHTML']
        end

        visit tasks_path(sort_created: "true")
        tasks_af = page.all(".task_name")
        tasks_af.each do |task|
          tasks_after << task['innerHTML']
        end
        
        tasks_after.reverse!
        
        expect(tasks_before[0]).to eq tasks_after[0]
        expect(tasks_before[1]).to eq tasks_after[1]
        expect(tasks_before[2]).to eq tasks_after[2]
        expect(tasks_before[3]).to eq tasks_after[3]
        expect(tasks_before[4]).to eq tasks_after[4]
      end
    end
    
    context 'タスクが終了期日の昇順に並んでいる場合' do
      it '期日の一番古いタスクが一番上に表示される' do
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
        FactoryBot.create(:forth_task)
        FactoryBot.create(:fifth_task)
        visit tasks_path
        tasks_before = []
        tasks_after = []
        
        tasks_bf = page.all(".task_name")
        tasks_bf.each do |task|
          tasks_before << task['innerHTML']
        end
        
        visit tasks_path(sort_expired: "true")
        tasks_af = page.all(".task_name")
        tasks_af.each do |task|
          tasks_after << task['innerHTML']
        end

        expect(tasks_before[2]).to eq tasks_after[0]
        expect(tasks_before[1]).to eq tasks_after[1]
        expect(tasks_before[3]).to eq tasks_after[2]
        expect(tasks_before[0]).to eq tasks_after[3]
        expect(tasks_before[4]).to eq tasks_after[4]
      end
    end
    
    context 'タスクが優先順位の昇順に並んでいる場合' do
      it '優先順位の高いタスクが一番上に表示される' do
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
        FactoryBot.create(:forth_task)
        FactoryBot.create(:fifth_task)
        
        visit tasks_path
        tasks_after = []

        visit tasks_path(sort_priority: "true")
        tasks_af = page.all(".task_name")
        tasks_af.each do |task|
          tasks_after << task['innerHTML']
        end
        
        expect(FactoryBot.create(:forth_task).task_name).to eq tasks_after[0]
      end
    end
  end
  
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, task_name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end
  
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        all('tbody tr')[1].click_link I18n.t('view.task_detail')
        expect(page).to have_content "test_name"
        expect(page).to have_content "test_detail"
      end
    end
  end
  
  describe '検索機能' do
    before do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      FactoryBot.create(:third_task)
      FactoryBot.create(:forth_task)
      FactoryBot.create(:fifth_task)
      visit tasks_path
    end
    context 'タイトルで検索した場合' do
      it '検索内容を含むタスクの内容が表示される' do
        fill_in "Task name", with: "e_3"
        click_button I18n.t('view.search')
        expect(page).to have_content "test_name_3"
      end
    end
    
    context 'ステータスで検索した場合' do
      it '該当ステータスのタスクのみ表示される' do
        select 'Done', from: 'task[status]'
        click_button I18n.t('view.search')
        expect(page).to have_content "test_name_4"
      end
    end
    
    context 'タイトルとステータスの両方で検索した場合' do
      it '該当ステータスのタスクかつ検索内容を含むタスクが表示される' do
        fill_in "Task name", with: "e_5"
        select 'ToDo', from: 'task[status]'
        click_button I18n.t('view.search')
        expect(page).to have_content "test_name_5"
      end
    end
  end
end