require 'tty-prompt'
class Plan < ActiveRecord::Base
    belongs_to :user
    belongs_to :place
    belongs_to :career

end