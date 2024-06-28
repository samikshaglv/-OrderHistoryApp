namespace :import do
  desc "Import users, orders, and products from CSV"
  task users_and_orders: :environment do
    require 'csv'

    def import_users(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        username = row['USERNAME']
        email = row['EMAIL']
        phone = row['PHONE']

        if username.present? && email.present?
          begin
            User.find_or_create_by!(username: username, email: email) do |user|
              user.phone = phone
            end
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error "User creation failed for email #{email}: #{e.message}"
          end
        else
          Rails.logger.warn "Skipped row due to missing required fields: #{row.to_h}"
        end
      end
    end

    def import_orders(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        user = User.find_by(email: row['USER_EMAIL'])
        if user
          begin
            user.orders.create!(
              product_code: row['PRODUCT_CODE'],
              date_of_purchase: row['ORDER_DATE']
            )
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error "Order creation failed for user #{user.email}: #{e.message}"
          end
        else
          Rails.logger.warn "User not found for email: #{row['USER_EMAIL']}"
        end
      end
    end

    def import_products(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        user = User.find_by(username: row['username'])
        if user
          begin
            user.orders.create!(
              code: row['CODE'],
              name: row['NAME'],
              category: row['CATEGORY']
            )
          rescue ActiveRecord::RecordInvalid => e
            Rails.logger.error "Product creation failed for user #{user.username}: #{e.message}"
          end
        else
          Rails.logger.warn "User not found for username: #{row['username']}"
        end
      end
    end

    users_file = Rails.root.join('csv_data', 'users.csv')
    orders_file = Rails.root.join('csv_data', 'order_details.csv')
    product_file = Rails.root.join('csv_data', 'products.csv')

    import_users(users_file)
    import_orders(orders_file)
    import_products(product_file)
  end
end
