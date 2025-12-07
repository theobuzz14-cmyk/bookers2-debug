class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    # Viewから受け取るパラメータ
    # 1. 検索対象 (user or book)
    @model = params[:model]
    # 2. 検索ワード
    @content = params[:content]
    # 3. 検索方法 (perfect, forward, backward, partial)
    @method = params[:method]

    # モデル（UserかBook）と検索方法に基づいて検索を実行し、@recordsに結果を格納
    @records = search_for(@model, @content, @method)
  end

  private

  # 検索処理のメインメソッド
  def search_for(model, content, method)
    # 検索対象がUserの場合
    if model == 'User'
      # Userモデルに定義する検索メソッドを呼び出す
      # (次のステップで User.searches を実装します)
      User.searches(content, method)
    # 検索対象がBookの場合
    elsif model == 'Book'
      # Bookモデルに定義する検索メソッドを呼び出す
      # (次のステップで Book.searches を実装します)
      Book.searches(content, method)
    end
  end
end
