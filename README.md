
（モデル名、カラム名、データ型）

User
|  id  |  email   |digest_password |  name  |
| ---- | -------- | -------------- | ------ |
| int  |  string  |  string        | string |


Task
|  id  |  task_name | task_detail | status |  due_date  | priority |
| ---- | ---------- | ----------- | ------ | ---------- | -------- |
| int  |   string   |   string    |  int   |  datetime  |   int    |


Label
|  id  |  label_name |
| ---- | ----------- | 
| int  |    string   |



rails g model user email:string password_digest:string name:string

rails g model task task_name:string status:int due_date:datetime priority:int task_detail:string

rails g model label label_name:string

bin/rails db:migrate:redo で自分が書いたマイグレーションが、バージョンを下げる際にも問題なく動く事を確認



作成するテーブルとカラムは、タスクの名前と詳細のみとする
rails g model task task_name:string task_detail:string
マイグレーションは1つ前の状態に戻せることを担保することが重要。redo を実行して確認する癖をつけましょう
rails db:migrate:redo
データベースの制約についても忘れずに設定する
データベースの制約を設定する（追記する）マイグレーションファイルを作成する。マイグレーションファイルだけを作成したいので、rails g migration コマンドで作成する