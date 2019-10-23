class Career < ActiveRecord::Base
    has_many :plans
    has_many :places, through: :plans
    has_many :users, through: :plans
    
end