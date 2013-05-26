class MicropostsController < ApplicationController
  # helper :current_user_id
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]

  def index
    @microposts = Micropost.order :created_at
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @post_content = params[:micropost][:post]
    @micropost = Micropost.new(post: @post_content, user_id: current_user_id)

    respond_to do |format|
      if @micropost.save
        format.html { redirect_to home_url, notice: 'Micropost was successfully created.' }
        format.json { render action: 'show', status: :created, location: @micropost }
      else
        format.html { redirect_to home_url, notice: 'Micropost could not be found.' }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microposts/1
  # PATCH/PUT /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        format.html { redirect_to @micropost, notice: 'Micropost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:post, :user_id)
    end


end
