class Industry < ActiveRecord::Base
  has_many :resource_industries
  has_many :resources, through: :resource_industries
  attr_accessible :name
end
