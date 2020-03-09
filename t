[1mdiff --git a/app/controllers/investments_controller.rb b/app/controllers/investments_controller.rb[m
[1mindex b8f123f..3140a68 100644[m
[1m--- a/app/controllers/investments_controller.rb[m
[1m+++ b/app/controllers/investments_controller.rb[m
[36m@@ -136,45 +136,42 @@[m [mclass InvestmentsController < ApplicationController[m
           url = helpers.asset_url('restaurant.png')[m
         end[m
 [m
[31m-      @markers << {[m
[31m-        lat: investment.campaign.company.latitude,[m
[31m-        lng: investment.campaign.company.longitude,[m
[31m-        infoWindow: render_to_string(partial: "info_window", locals: { investment: investment }),[m
[31m-        image_url: url[m
[31m-      }[m
[32m+[m[32m        @markers << {[m
[32m+[m[32m          lat: investment.campaign.company.latitude,[m
[32m+[m[32m          lng: investment.campaign.company.longitude,[m
[32m+[m[32m          infoWindow: render_to_string(partial: "info_window", locals: { investment: investment }),[m
[32m+[m[32m          image_url: url[m
[32m+[m[32m        }[m
       # authorize @markers[m
 [m
[31m-      end[m
[31m-[m
[31m-[m
[31m-[m
     end[m
[32m+[m[32m  end[m
 [m
[31m-    def show[m
[31m-      @investment = Investment.find(params[:id])[m
[31m-      authorize @investment[m
[31m-    end[m
[32m+[m[32m  def show[m
[32m+[m[32m    @investment = Investment.find(params[:id])[m
[32m+[m[32m    authorize @investment[m
[32m+[m[32m  end[m
 [m
[31m-    def new[m
[31m-      @campaign = Campaign.find(params[:campaign_id])[m
[31m-      authorize @campaign[m
[31m-      @investment = Investment.new(amount: params["investment"]["amount"])[m
[31m-      authorize @investment[m
[32m+[m[32m  def new[m
[32m+[m[32m    @campaign = Campaign.find(params[:campaign_id])[m
[32m+[m[32m    authorize @campaign[m
[32m+[m[32m    @investment = Investment.new(amount: params["investment"]["amount"])[m
[32m+[m[32m    authorize @investment[m
 [m
[31m-      @reward = @campaign.rewards.first[m
[32m+[m[32m    @reward = @campaign.rewards.first[m
 [m
[31m-      @investment.campaign = @campaign[m
[31m-      @investment.reward = @reward[m
[31m-      @investment.investor = current_user[m
[32m+[m[32m    @investment.campaign = @campaign[m
[32m+[m[32m    @investment.reward = @reward[m
[32m+[m[32m    @investment.investor = current_user[m
 [m
 [m
[31m-      if @investment.valid?[m
[31m-        @investment.save[m
[31m-        investment_link = investment_url(@investment)[m
[31m-        session = Stripe::Checkout::Session.create([m
[31m-          payment_method_types: ['card'],[m
[31m-          line_items: [{[m
[31m-            name: @campaign.title,[m
[32m+[m[32m    if @investment.valid?[m
[32m+[m[32m      @investment.save[m
[32m+[m[32m      investment_link = investment_confirmation_url(@investment)[m
[32m+[m[32m      session = Stripe::Checkout::Session.create([m
[32m+[m[32m        payment_method_types: ['card'],[m
[32m+[m[32m        line_items: [{[m
[32m+[m[32m          name: @campaign.title,[m
           # images: @campaign.photo_url],[m
 [m
           amount: @investment.amount * 100,[m
[36m@@ -186,22 +183,30 @@[m [mclass InvestmentsController < ApplicationController[m
         cancel_url: campaigns_url[m
         )[m
 [m
[31m-        @investment.update(stripe_session_id: session.id)[m
[31m-      else[m
[31m-        render :new[m
[32m+[m[32m      @investment.update(stripe_session_id: session.id)[m
[32m+[m[32m    else[m
[32m+[m[32m      render :new[m
 [m
[31m-      end[m
     end[m
[32m+[m[32m  end[m
 [m
[31m-    def create[m
[31m-      @investment = Investment.new()[m
[31m-      authorize @investment[m
[32m+[m[32m  def create[m
[32m+[m[32m    @investment = Investment.new()[m
[32m+[m[32m    authorize @investment[m
 [m
[31m-      @investment.reward_id = params[:investment][:reward].to_i[m
[31m-      @investment.amount = params["investment"]["amount"][m
[32m+[