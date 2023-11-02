class Api::V1::PostController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  ## API for listing all the post 
  def index
    posts = Post.all();
    render json: posts, status:200
  end

  ## API for displaying single post detiails
  def show
    post = Post.find(params[:id])
    if post
      render json: post, status:200
    else
      render json: {
          error: "Post Not Found."
      } 
    end
  end

  ## API for creating a new post 
  def create
    post = Post.new(
        title: post_params[:title],
        content: post_params[:content],
        category_id: post_params[:category_id],
        user_id: post_params[:user_id]
      )

    # check post is save or not
    if post.save
      render json: post, status:200
    else
      render json: { error: "there is some error in creating post"} 
    end
  end

  ## API for updating a post 
  def update
      post = Post.find(params[:id])

      # check post is save or not
      if post
        post.update(title: params[:title], content: params[:content], category_id: params[:category_id], user_id: params[:user_id])
        render json: post, status:200
      else
        render json: { error: "Post Not Found."} 
      end
  end

  ## API for deleteing a post 
  def destroy
      post = Post.find(params[:id])
      if post
        post.destroy
        render json:  { error: "Post has been deleted Found."} 
      else
        render json: { error: "Post Not Found."} 
      end
  end

  private
  def post_params
    params.require(:post).permit(:content, :title, :category_id, :user_id)
  end
end
