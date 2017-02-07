class SearchesController < ApplicationController

  def index

  end

  def search
    parameters = { term: params[:term], limit: 16 }
    city = params[:city]
    render json: Yelp.client.search(city, parameters)
  end
end
