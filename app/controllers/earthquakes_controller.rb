class EarthquakesController < ApplicationController
  def index
    since = params[:since].try(:to_i).presence
    on = params[:on].try(:to_i).presence
    over = params[:over].try(:to_f).presence
    near = params[:near].try { |s|  s.split(",").map(&:to_f) }.presence

    @quakes = Earthquake.since( since ).on( on ).over( over ).near( *near )
    render json: @quakes
  end
end