class Category < ActiveRecord::Base
	has_many :sub_categories,:dependent=>:destroy
	has_many :messages,:dependent=>:destroy
end
