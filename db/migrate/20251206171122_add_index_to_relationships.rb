class AddIndexToRelationships < ActiveRecord::Migration[6.1]
  def change
    # 検索速度向上のためのインデックス
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    
    # follower_id と followed_id のペアを一意にする複合インデックス
    # これにより、同じユーザーを二度フォローできなくなる
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
