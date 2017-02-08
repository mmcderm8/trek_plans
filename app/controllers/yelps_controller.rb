class YelpsController < ApplicationController
  def index

  end

  def search
    parameters = { term: params[:term], limit: 1 }
    city = params[:city]
    render json: Yelp.client.search(city, parameters)
  end

end
