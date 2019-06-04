class Customer < ActiveRecord::Base
  has_many :nodes, dependent: :destroy

  validates :enrollment_secret, presence: true, uniqueness: true
end
