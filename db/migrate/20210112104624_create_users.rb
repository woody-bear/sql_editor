class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :user, primary_key: "user_seq", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade  do |t|
      t.string "email", comment: "이메일"
      t.string "password", comment: "비밀번호"
      t.string "nickname", comment: "별명"
      t.datetime "create_at", comment: "생성일"
      t.datetime "update_at", comment: "수정일"
    end
  end
end
