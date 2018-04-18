class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(permitted_params)
    if @post.user == current_user
      @post.save
      redirect_to @post
    else
      render 'posts/access_error'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user == current_user
      if @post.update_attributes(permitted_params)
        redirect_to @post
      else
        render 'edit'
      end
    else
      render 'posts/access_error'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path
    else
      render 'posts/access_error'
    end
  end

  private

  def permitted_params
    params.require(:post).permit(:title, :url).merge(user_id: current_user.id)
  end
end
