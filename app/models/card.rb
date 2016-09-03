class Card < ActiveRecord::Base
  belongs_to :user

  self.primary_key = 'card_id'
end
