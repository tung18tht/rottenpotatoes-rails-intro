class Movie < ActiveRecord::Base
    def self.ratings
        Array['G', 'R', 'PG-13', 'PG']
    end
end
