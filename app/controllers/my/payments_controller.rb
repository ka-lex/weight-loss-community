class My::PaymentsController < My::ApplicationController
  
SECRET_KEY = ENV["SECRET_KEY"]

	def new
		#create a new payment
	end


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

	p sig_test
	sig_test_md5 = Digest::MD5.hexdigest(sig_test)

	if @sig == sig_test_md5
		render :text => "OK", :layout => false, :status => 200
	else
		render :text => "ERROR", :layout => false, :status => 200
	end
  end

end
