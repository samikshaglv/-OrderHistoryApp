# app/models/user.rb
class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end

# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  validates :product_code, presence: true
  validates :date_of_purchase, presence: true
end
