class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships, source: :followed
  
  # フォロワー (自分をフォローしている人たち)
  has_many :follower_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  
  # フォロー/アンフォロー判定メソッドの追加
  def following?(user)
    followings.include?(user)
  end

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  # ★★★ ここから検索ロジックの追加 ★★★
  # ユーザー検索ロジック (nameに対する検索)
  def self.searches(content, method)
    if method == 'perfect'
      # 完全一致: name が content と完全に一致
      where('name LIKE ?', content)
    elsif method == 'forward'
      # 前方一致: name が content で始まる
      where('name LIKE ?', content + '%')
    elsif method == 'backward'
      # 後方一致: name が content で終わる
      where('name LIKE ?', '%' + content)
    else
      # 部分一致 (partial) またはそれ以外: name のどこかに content が含まれる
      where('name LIKE ?', '%' + content + '%')
    end
  end
  # ★★★ ここまで検索ロジックの追加 ★★★
end
