class MoviesController < ApplicationController


  def index
    if params[:search] == ""
      redirect_to user_discover_path(@user)
      flash[:alert] = "Search Field Can't Be Blank"
    else
      @movies = if params[:search]
                  MoviesFacade.searched_movies(params[:search])
                else
                  MoviesFacade.top_rated_movies
                end
    end
  end

  def show
    @movie = MoviesFacade.movie_details(params[:id])
    @user = User.find(session[:user_id])
  end
end
