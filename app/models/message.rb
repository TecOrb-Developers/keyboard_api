class Message < ActiveRecord::Base
  belongs_to :sub_category
  belongs_to :category
end
