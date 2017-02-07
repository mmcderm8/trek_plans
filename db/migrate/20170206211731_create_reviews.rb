class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|

      t.integer  "activity_id",             null: false
      t.integer  "reviewer_id",             null: false
      t.integer  "rating",                  null: false
      t.text     "body"
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
      t.integer  "sum_votes",   default: 0, null: false
    end
  end
end
