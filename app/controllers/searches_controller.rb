class SearchesController < ApplicationController

  def index

  end

  def search
    parameters = { term: params[:term], limit: 16 }
    render json: Yelp.client.search('london', parameters)
  end
end
