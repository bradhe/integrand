class CreateBuilds < ActiveRecord::Migration
  def self.up
    create_table :builds do |t|
      t.integer :integration_id
      t.string :commit_id
      t.string :status
      t.datetime :started_at
      t.datetime :ended_at
      t.boolean :forced, :default => true
      t.string :output_file

      t.timestamps
    end
  end

  def self.down
    drop_table :builds
  end
end
