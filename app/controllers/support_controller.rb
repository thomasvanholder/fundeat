class SupportController < ApplicationController
  def create
    authorize current_user, :logged_in?
    flash[:notice] = "Message successfully sent"
    SupportMailer.appointment(owner: current_user.owner, name: support_params[:name], email: support_params[:email], message: support_params[:message], date: support_params[:date], ).deliver_now
    redirect_to owners_support_path
  end

  private

  def support_params
    params.require(:support).permit(:name, :email, :message, :date)
  end


end
