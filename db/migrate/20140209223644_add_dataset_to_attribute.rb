class AddDatasetToAttribute < ActiveRecord::Migration
  def change
    add_column :attributes, :dataset_id, :integer
  end
end
