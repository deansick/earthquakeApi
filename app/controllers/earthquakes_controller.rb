class EarthquakesController < ApplicationController
  def index
    @quakes = Earthquake.since(params[:since]).on(params[:on]).over(params[:over]).near(params[:near])
    render json: @quakes
  end
end