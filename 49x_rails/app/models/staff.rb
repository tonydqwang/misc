class Staff < ActiveRecord::Base
  attr_accessible :pool_id, :user_id
  belongs_to :pool
  belongs_to :user
  validates :pool_id, presence: true
  validates :user_id, presence: true
end
