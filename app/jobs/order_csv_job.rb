class OrderCsvJob < ApplicationJob
  queue_as :default

  require 'csv'

  def perform(user_id)
    user = User.find_by(id: user_id)
    if user
      orders_csv = generate_csv(user)
      file_path = Rails.root.join('tmp', "#{user.username}_orders.csv")
      FileUtils.mkdir_p(File.dirname(file_path)) # Ensure the directory exists
      File.write(file_path, orders_csv)

      # Update user with the file path for download
      user.update(csv_download_path: file_path)
    else
      Rails.logger.error "User not found with ID #{user_id}"
    end
  rescue StandardError => e
    Rails.logger.error "Failed to generate CSV for user ID #{user_id}: #{e.message}"
  end

  private

  def generate_csv(user)
    CSV.generate(headers: true) do |csv|
      csv << ["USER_EMAIL", "Product Code", "Date of Purchase"]
      user.orders.each do |order|
        csv << [user.email, order.product_code, order.date_of_purchase]
      end
    end
  end
end
