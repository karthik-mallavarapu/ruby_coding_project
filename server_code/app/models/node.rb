class Node < ActiveRecord::Base
  belongs_to :customer

  validates :host_identifier, presence: true, uniqueness: true
  validates :key, presence: true, uniqueness: true
end

