class Movie < ActiveRecord::Base
  def self.all_ratings
    ['G','PG','PG-13','R']
  end
  
  def self.ratings_to_show(checkbox_ratings)
    if checkbox_ratings != nil
      checkbox_ratings.keys
    else
      self.all_ratings
    end
  end
  def self.with_ratings(ratings_list)
    if ratings_list != nil
      Movie.where(rating: ratings_list)
    else
      Movie
    end
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
  #  movies with those ratings
  # if ratings_list is nil, retrieve ALL movies
  end
end
