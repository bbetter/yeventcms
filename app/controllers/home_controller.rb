class HomeController < ApplicationController
  def index
    @latest_events = Event.order(created_at: :desc).limit(5)
    @categories = Category.includes(:events)
  end
end
