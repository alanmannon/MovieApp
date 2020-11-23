class Api::MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render "index.json.jb"
  end

  def show
    response = HTTP.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.OMDb_api[:api_key]}&i=#{params[:imdb]}")

    response = response.parse
    render "show.json.jb"
  end
end
