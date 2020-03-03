class CampaignsController < ApplicationController
 #Note! pundit was implemented. remember to authorize your variables with for example. authorize@campaign

  def index
  end

  def show
  end

  def new
  end

  def create
    authorize @campaign

  end

  def edit
  end

  def update
  end

end
