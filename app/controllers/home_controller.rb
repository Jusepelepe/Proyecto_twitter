class HomeController < ApplicationController
  def index
    @tweets = Tweet.order(created_at: :desc).page params[:page]
  end
end
