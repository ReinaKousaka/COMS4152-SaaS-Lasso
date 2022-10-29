class Movie < ActiveRecord::Base
    def self.all_ratings
        return ['G', 'PG', 'PG-13', 'R']
    end

    def self.ratings_to_show(checkbox_ratings=nil)
        if checkbox_ratings.nil?
            return self.all_ratings
        else
            return checkbox_ratings.keys
        end
    end

    def self.with_ratings(ratings_list, sort=nil)
        if ratings_list
            res = Movie.where(rating: ratings_list)
        else
            res = Movie.all
        end
        if sort == 'title'
            return res.order(:title)
        elsif sort == 'release_date'
            return res.order(:release_date)
        else
            return res
        end
    end
end