class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @book = Book.find(params[:book_id])
    # コメントの内容を受け取る (ストロングパラメーターを使用)
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    if comment.save
      # コメント作成後は元の投稿詳細画面へリダイレクト
      redirect_to book_path(@book)
    else
      # エラー時は詳細画面を再描画するため、必要なインスタンス変数を準備
      @new_book = Book.new
      @book_comments = @book.book_comments
      # バリデーションエラーメッセージを flash に格納
      flash[:error] = comment.errors.full_messages
      render 'books/show' # render で詳細画面へ
    end
  end

  def destroy
    # コメントを特定し、それが現在のユーザーのものであるかチェックして削除
    BookComment.find_by(id: params[:id], book_id: params[:book_id], user_id: current_user.id).destroy
    # 削除後は元の投稿詳細画面へリダイレクト
    redirect_to book_path(params[:book_id])
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
