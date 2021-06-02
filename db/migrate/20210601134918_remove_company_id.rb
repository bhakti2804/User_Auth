class RemoveCompanyId < ActiveRecord::Migration[6.0]
  def change
  	remove_column :users, :companyID
  end
end
