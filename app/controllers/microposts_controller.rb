class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit  
     @micropost = Micropost.find(params[:id])
  end

  def update  
    @micropost = Micropost.find(params[:id])
    @micropost.update(micropost_params)

    redirect_to root_url
  end 

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def vote
    value = params[:type] == "Like" ? 1: -1
    @micropost = Micropost.find(params[:id])
    @micropost.add_evaluation(:votes, value, current_user)
    flash[:success] = "Like!"
    redirect_to :back
  end
  
  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
