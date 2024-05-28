class SorceryCore < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations, id: :uuid do |t|
      t.boolean :deactivated, default: false
      t.references :created_by, foreign_key: { to_table: :users }

      t.timestamps
    end

    create_table :users do |t|
      t.string :name, null: false
      t.string :crypted_password
      t.string :salt
      t.references :invitation, foreign_key: { to_table: :invitations }, type: :uuid, null: false

      t.timestamps null: false
    end
  end
end
