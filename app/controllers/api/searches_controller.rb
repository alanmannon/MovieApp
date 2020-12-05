class Api::SearchesController < ApplicationController
  def index
    search = params[:search]
    search = search.gsub(" ", "+")

    # response = HTTP.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.OMDb_api[:api_key]}&s=#{search}")

    response = HTTP.get("http://www.omdbapi.com/?apikey=[YOUR API KEY HERE]&s=#{search}")

    parsed = response.parse
    @movies = parsed["Search"]
    render "index.json.jb"
  end

  def show
    imdb = params[:id]

    # response = HTTP.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.OMDb_api[:api_key]}&i=#{imdb}")

    response = HTTP.get("http://www.omdbapi.com/?apikey=[YOUR API KEY HERE]&i=#{imdb}")

    @api_movie = response.parse
    db_movie = Movie.find_by(imdb: imdb)

    if db_movie
      @movie = db_movie
    else
      new_movie = Movie.new(
        title: @api_movie["Title"],
        year: @api_movie["Year"],
        image: @api_movie["Poster"],
        imdb: @api_movie["imdbID"],
        thumbs_up: 0,
        thumbs_down: 0,
      )
      new_movie.save
      @movie = new_movie
    end
    render "show.json.jb"
  end
end
