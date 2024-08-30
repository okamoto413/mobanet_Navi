class CreateRecommendedPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :recommended_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.text :reason, null: false

      t.timestamps
    end
  end
end
