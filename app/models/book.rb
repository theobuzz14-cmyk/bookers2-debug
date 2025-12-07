class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
   # ★★★ ここから検索ロジックの追加 ★★★
  # 投稿検索ロジック (titleに対する検索)
  def self.searches(content, method)
    if method == 'perfect'
      # 完全一致: title が content と完全に一致
      where('title LIKE ?', content)
    elsif method == 'forward'
      # 前方一致: title が content で始まる
      where('title LIKE ?', content + '%')
    elsif method == 'backward'
      # 後方一致: title が content で終わる
      where('title LIKE ?', '%' + content)
    else
      # 部分一致 (partial) またはそれ以外: title のどこかに content が含まれる
      where('title LIKE ?', '%' + content + '%')
    end
  end
  # ★★★ ここまで検索ロジックの追加 ★★★
end
