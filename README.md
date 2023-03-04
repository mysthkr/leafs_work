
（モデル名、カラム名、データ型）

User
|  id  |  email   |digest_password |  name  |
| ---- | -------- | -------------- | ------ |
| int  |  string  |  string        | string |


Task
|  id  |  task_name | task_detail | status |  due_date  | priority |
| ---- | ---------- | ----------- | ------ | ---------- | -------- |
| int  |   string   |   string    | string |  datetime  |   int    |


Label
|  id  |  label_name |
| ---- | ----------- | 
| int  |    string   |


###Heroku###
heroku login
heroku config
git add .
git commit -m ""
git push heroku step2:master