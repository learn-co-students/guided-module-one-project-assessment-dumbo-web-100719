class User < ActiveRecord::Base
    has_many :bikes
    has_many :requested_users, foreign_key: :requester_bike_id, class_name: 'Request'
    has_many :requestees, through: :requested_users

    has_many :requesting_users, foreign_key: :requestee_bike_id, class_name: 'Request'
    has_many :requesters, through: :requesting_users
end
