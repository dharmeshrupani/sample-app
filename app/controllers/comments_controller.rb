class CommentsController < ApplicationController
	before_action :set_micropost

	def create  
  		@comment = @micropost.comments.build(comment_params)
  		@comment.user_id = current_user.id

  		if @comment.save
    		flash[:success] = "Commented!"
    		redirect_to :back
  		else
    		flash[:alert] = "Check the comment form, something went wrong."
    		render root_path
  		end
	end

  def destroy  
    @comment = @micropost.comments.find(params[:id])

    @comment.destroy
    flash[:success] = "Comment deleted :("
    redirect_to root_path
end  

private

	def comment_params  
  		params.require(:comment).permit(:content)
	end

	def set_micropost 
      @micropost = Micropost.find(params[:micropost_id])
	end

end
