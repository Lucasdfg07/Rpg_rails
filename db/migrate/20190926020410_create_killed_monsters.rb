class CreateKilledMonsters < ActiveRecord::Migration[5.2]
  def change
    create_table :killed_monsters do |t|
      t.integer :user_id
      t.integer :monster_id
    end
  end
end
