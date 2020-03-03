class InvestmentsController < ApplicationController
  def index
    @investments = policy_scope(Investment)
    authorize @investments
  end

  def show
  end

  def new
  end

  def create
  end
end
