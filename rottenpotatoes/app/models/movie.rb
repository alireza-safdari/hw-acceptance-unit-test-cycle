class Movie < ActiveRecord::Base
    def self.by_same_director(director)
        self.all.where(director: director)
    end
end
