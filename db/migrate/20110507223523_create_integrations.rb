class CreateIntegrations < ActiveRecord::Migration
  def self.up
    create_table :integrations do |t|
      t.string :name
#      t.string :path

      t.timestamps
    end
  end

  def self.down
    drop_table :integrations
  end
end
