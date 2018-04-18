class PostsController < ApplicationController
	before_action :authenticate_user!

	def index
		@posts = Post.all
	end

	def new
	end

	def create
		@post = Post.new(permitted_params)
		@post.save
		redirect_to @post
	end

	def edit
		@post = Post.find(params[:id])
	end

	def show
		@post = Post.find(params[:id])
	end

	def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
    	@post.destroy
    end
    redirect_to posts_path
  end

	private

	def permitted_params
    params.require(:post).permit(:title, :url).merge(user_id: current_user.id)
  end
end
