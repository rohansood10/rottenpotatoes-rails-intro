class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort_by = params[:sort_by]
    if sort_by != nil and sort_by == 'title'
      @title_header = 'hilite bg-warning'
      if @release_date_header != nil
        @release_date_header = nil
      end
    end
    if sort_by != nil and sort_by == 'release_date'
      @release_date_header = 'hilite bg-warning'
      if @title_header != nil
        @title_header = nil
      end
    end
    @all_ratings = Movie.all_ratings
    @ratings_to_show = Movie.ratings_to_show(params[:ratings])
    if sort_by == nil
      if @ratings_to_show == []
        @movies = Movie.with_ratings(@all_ratings)
      else
        @movies = Movie.with_ratings(@ratings_to_show)
      end
    else
      if @ratings_to_show == []
        @movies = Movie.with_ratings_sorted(@all_ratings, sort_by)
      else
        @movies = Movie.with_ratings_sorted(@ratings_to_show, sort_by)
      end
    end
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
