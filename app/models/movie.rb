class Movie < ActiveRecord::Base
    def self.ratings
        Array['G','PG','PG-13','R']
    end
end
