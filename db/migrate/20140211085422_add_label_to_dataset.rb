class AddLabelToDataset < ActiveRecord::Migration
  def change
    add_column :datasets, :label, :string
  end
end
