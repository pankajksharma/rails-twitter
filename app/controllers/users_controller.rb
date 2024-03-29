class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followers, :following]
  before_action :set_follow_counts, only: [:show, :followers, :following]
  before_action :authorize, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @microposts = @user.micropost.paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # GET /user/:id/followers
  def followers
    @followers = Relationship.where(followed_id: @user.id).paginate(page: params[:page])
  end

  # GET /user/:id/followings
  def following
    @followed_users = Relationship.where(follower_id: @user.id).paginate(page: params[:page])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to home_url, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

  private

    def set_follow_counts
      @followers_count = Relationship.where(followed_id: @user.id).count
      @following_count = Relationship.where(follower_id: @user.id).count
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def authorize
      redirect_to login_url, notice: 'Please login.' unless correct_user
    end


    def correct_user
      if current_user_id
        current_user_id == @user.id
      else
        false
      end
    end

end
