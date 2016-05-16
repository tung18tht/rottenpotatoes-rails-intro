class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    session[:sort] = params[:sort] || session[:sort]
    session[:ratings] = params[:ratings] || session[:ratings] || 1

    @movies = Movie.all
    sort = session[:sort]
    if sort === "title"
      @movies = Movie.order(sort)
      @title_header = "hilite"
    elsif sort === "release_date"
      @movies = Movie.order(sort)
      @release_date_header = "hilite"
    end

    @all_ratings = Movie.ratings
  
    @session_ratings = session[:ratings] || params[:ratings] || {"G"=>"1", "PG"=>"1", "PG-13"=>"1", "R"=>"1"}

    @movies = @movies.where(:rating => @session_ratings.keys)
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

end
