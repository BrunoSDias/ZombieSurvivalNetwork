class AddInfectedAndReportCounterToSurvivor < ActiveRecord::Migration[5.2]
  def change
    add_column :survivors, :infected, :boolean, default: false
    add_column :survivors, :report_counter, :integer, default: 0
  end
end
