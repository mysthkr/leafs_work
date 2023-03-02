require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    before do
      # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
      visit tasks_path
    end
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        # 2. 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in "Task name", with: "test name"
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in "Task detail", with: "test detail"
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_button '登録する'
        expect(page).to have_content "test name"
        expect(page).to have_content "test detail"
      end
    end
    # テスト内容を追加で記載する
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # ここに実装する
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
        FactoryBot.create(:third_task)
        FactoryBot.create(:forth_task)
        FactoryBot.create(:fifth_task)
        
        visit tasks_path
        tasks_before = []
        tasks_after = []
        tasks = page.all(".task_name")
        
        tasks.each do |task|
          tasks_before << task['innerHTML']
        end

        click_link '作成日時降順'
        
        tasks_af = page.all('.task_name')
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
  end
  
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, task_name: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
  end
  
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        all('tbody tr')[1].click_link 'タスク詳細'
        expect(page).to have_content "test_name"
        expect(page).to have_content "test_detail"
      end
    end
  end
end