class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:body))
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post)
  end
end
