class Api::MoviesController < ApplicationController
  def index
    @movies = Movie.where("(thumbs_up) > 0").or(Movie.where("(thumbs_down) > 0"))
    render "index.json.jb"
  end

  def create
    if !Movie.find_by(imdb: params[:imdb])
      response = HTTP.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.OMDb_api[:api_key]}&i=#{params[:imdb]}")

      omdb = response.parse
      @movie = Movie.new(
        title: omdb["Title"],
        year: omdb["Year"],
        image: omdb["Poster"],
        imdb: omdb["imdbID"],
        thumbs_up: 0,
        thumbs_down: 0,

      )
      if @movie.save!
        render "show.json.jb"
      else
        render json: { error: @movie.errors }
      end
    end
  end

  def update
    if params[:thumb] == "1"
      @movie = Movie.find_by(imdb: params[:id])
      @movie.thumbs_up = params[:new]
      @movie.save
    elsif params[:thumb] == "0"
      @movie = Movie.find_by(imdb: params[:id])
      @movie.thumbs_down = params[:new]
      @movie.save
    end
    render "show.json.jb"
  end
end
