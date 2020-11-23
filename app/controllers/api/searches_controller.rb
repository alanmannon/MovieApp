class Api::SearchesController < ApplicationController
  def index
    response = HTTP.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.OMDb_api[:api_key]}&s=avengers")

    parsed = response.parse

    @message = parsed["Search"]
    render "index.json.jb"
  end
end
