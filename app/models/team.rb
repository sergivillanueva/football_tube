class Team < ActiveRecord::Base
  attr_accessible :name, :nick_names, :emblem, :nationality
end
