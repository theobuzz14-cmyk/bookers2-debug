class Relationship < ApplicationRecord
  # follower (フォローする人)
  # foreign_keyは省略可能だが、可読性を高めるために明示。
  # class_name: 'User' で外部キーがUserモデルを参照することを明示
  belongs_to :follower, class_name: "User"
  
  # followed (フォローされる人)
  belongs_to :followed, class_name: "User"
  
  # バリデーション
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
