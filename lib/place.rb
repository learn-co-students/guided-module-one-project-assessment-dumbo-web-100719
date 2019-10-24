class Place < ActiveRecord::Base
    has_many :plans
    has_many :users, through: :plans
    has_many :careers, through: :plans

end