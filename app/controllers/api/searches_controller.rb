class Api::SearchesController < ApplicationController
  def index
    search = params[:search]
    search = search.gsub(" ", "+")

    response = HTTP.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.OMDb_api[:api_key]}&s=#{search}")

    parsed = response.parse
    @movies = parsed["Search"]
    render "index.json.jb"
  end

  def show
    imdb = params[:id]

    response = HTTP.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.OMDb_api[:api_key]}&i=#{imdb}")

    @movie = response.parse
    if Movie.find_by(imdb: params[:id])
      @thumbs = Movie.find_by(imdb: params[:id])
    else
      @thumbs = ({ "thumbs_up": 0, "thumbs_down": "0" })
    end

    render "show.json.jb"
  end
end
