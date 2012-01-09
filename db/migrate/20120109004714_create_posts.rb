class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.datetime :sanitized_at
      t.datetime :processed_at
      t.datetime :autoposted_at

      t.timestamps
    end
  end
end
