class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index]

  def home
    @campaigns = Campaign.all
  end

  def index

  end
end
