class CreateIntegrations < ActiveRecord::Migration
  def self.up
    create_table :integrations do |t|
      t.string :name
      t.string :repository
      t.text :prebuild_command, :default => 'rake db:test:prepare'
      t.text :build_command, :default => 'rake spec'

      t.timestamps
    end
  end

  def self.down
    drop_table :integrations
  end
end
