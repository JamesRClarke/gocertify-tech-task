class CreateCampaigns < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :description
      t.integer :state, default: 0
      t.datetime :published_at, null: true
      t.integer :position

      t.timestamps
    end
  end
end
