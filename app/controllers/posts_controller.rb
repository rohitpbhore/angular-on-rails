class PostsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
	def index
    @posts =  if params[:keywords]
                Post.where('title like ?',"%#{params[:keywords]}%")
              else
                []
              end
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params.require(:post).permit(:title,:description))
    @post.save
    render 'show', status: 201
  end

  def update
    post = Post.find(params[:id])
    post.update_attributes(params.require(:post).permit(:title,:description))
    head :no_content
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    head :no_content
  end
end
