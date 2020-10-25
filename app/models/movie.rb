class Movie < ActiveRecord::Base
  def self.all_ratings
    ['G','PG','PG-13','R']
  end
  
  def self.ratings_to_show(checkbox_ratings)
    if checkbox_ratings != nil
      checkbox_ratings.keys
    else
      []
    end
  end
  def self.with_ratings(ratings_list)
    if ratings_list != nil
      Movie.where(rating: ratings_list)
    else
      Movie.all
    end
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
  end
  
  def self.with_ratings_sorted(ratings_list, sort_by)
    to_return = self.with_ratings(ratings_list)
    if (sort_by == 'title')
      to_return.order(title:)
    else
      to_return.order(release_date:)
    end
  end
end
