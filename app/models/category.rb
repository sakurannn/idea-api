class Category < ApplicationRecord
  has_many :ideas
  accepts_nested_attributes_for :ideas
end
