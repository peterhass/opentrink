class AddRoleToInvitation < ActiveRecord::Migration[7.1]
  def change
    change_table :invitations do |t|
      t.string :role, default: 'bar', null: false
    end
  end
end
