class Item < ActiveRecord::Base
  belongs_to :user
  validates :item_name, presence: true
  validates :brand, presence: true
end