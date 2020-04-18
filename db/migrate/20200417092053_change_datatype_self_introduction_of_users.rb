class ChangeDatatypeSelfIntroductionOfUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :self_introduction, :text
  end
end
