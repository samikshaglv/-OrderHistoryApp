class AddCsvDownloadPathToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :csv_download_path, :string
  end
end
