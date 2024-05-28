class CreateHardwares < ActiveRecord::Migration[7.1]
  def change
    create_table :hardwares do |t|
      t.string :name
      t.string :type
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
