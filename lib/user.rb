class User < ActiveRecord::Base
    has_many :plans 
    has_many :places, through: :plans
end
