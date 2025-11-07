class CreatePhoneNumbers < ActiveRecord::Migration[8.1]
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.string :status

      t.timestamps
    end
  end
end
