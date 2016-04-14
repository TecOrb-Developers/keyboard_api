class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :messages,:dependent=>:destroy
end
