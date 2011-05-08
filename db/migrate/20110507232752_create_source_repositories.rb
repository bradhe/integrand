class CreateSourceRepositories < ActiveRecord::Migration
  def self.up
    create_table :source_repositories do |t|
      t.string :source_control_type
      t.string :path

      t.timestamps
    end

    add_column :integrations, :source_repository_id, :integer
  end

  def self.down
    remove_column :integrations, :source_repository_id
    drop_table :source_repositories
  end
end
