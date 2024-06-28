# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end

  def download_orders
    user = User.find(params[:id])
    if user
      OrderCsvJob.perform_later(user.id)
      redirect_to users_path(page: params[:page]), notice: 'CSV is being generated and will be available shortly.'
    else
      redirect_to users_path(page: params[:page]), alert: 'User not found.'
    end
  end

  def download_csv
    user = User.find(params[:id])
    if user && user.csv_download_path.present?
      send_file Rails.root.join('tmp', user.csv_download_path), type: 'text/csv', disposition: 'attachment'
    else
      redirect_to users_path, alert: 'CSV file is not ready yet.'
    end
  end
end
