class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image

  # follower (フォローする人)
  # foreign_keyは省略可能だが、可読性を高めるために明示。
  # class_name: 'User' で外部キーがUserモデルを参照することを明示
  belongs_to :follower, class_name: "User"
  
  # followed (フォローされる人)
  belongs_to :followed, class_name: "User"
  
  # バリデーション
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
