class DeleteYearColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :year
  end
end
