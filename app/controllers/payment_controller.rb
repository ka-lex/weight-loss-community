class PaymentController < ApplicationController
  
SECRET_KEY = ENV["SECRET_KEY"]

  def confirm

  	

logger.info 'payment confirmation'
logger.info "Params: #{params.to_json}"

	@user_id = params[:uid] #my user id I sent on billing request
#	@currency = params[:currency] # no currency when using subscription !
	@type = params[:type]
	@ref =  params[:ref]
	@sig = params[:sig]


#@user_id = 1
#@currency = 2
#@type = 0
#@ref = 3

@goodsid = params[:goodsid]
@slength = params[:slength]
@speriod = params[:speriod]


sig_test = "uid=#{@user_id}goodsid=#{@goodsid}slength=#{@slength}speriod=#{@speriod}type=#{@type}ref=#{@ref}#{SECRET_KEY}"
	
	sig_test_md5 = Digest::MD5.hexdigest(sig_test)

	if @sig == sig_test_md5

    #kein Zugriff auf "current_user", da die API von extern aufgerufen wird.
    user = User.find @user_id

    subscription = Subscription.new
    subscription.plan_name = @goodsid
    subscription.next_renewal_at = Subscription.calculate_renewal @slength.to_i, @speriod
    subscription.psp_reference = @ref

    user.account.subscription = subscription
    subscription.save

		render :text => "OK", :layout => false, :status => 200
	else
		render :text => "ERROR", :layout => false, :status => 200
	end
  end

private

  

end
