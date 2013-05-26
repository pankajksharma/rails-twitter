class HomeController < ApplicationController
  def index
  	if current_user_id
		@current_user = current_user
		@micropost = @current_user.micropost.build
  		@microposts = @current_user.micropost.paginate(page: params[:page])
  	else
  		@microposts = Micropost.all.paginate(page: params[:page])
  	end
  end
end
