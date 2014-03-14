class EarthquakesController < ApplicationController
  def index
    render json: Earthquake.since(params[:since]).on(params[:on]).over(params[:over]).near(params[:near])
  end
end