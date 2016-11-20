class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.includes(:user)
  end
  
  def new
    if params[:back]
      @post = Post.new(blogs_params)
    else
      @post = Post.new
    end
  end

  def create
    @post = Post.new(blogs_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice:"投稿しました！"
      NoticeMailer.sendmail_blog(@post).deliver
    else
      render action: 'new'
    end
  end

  
  def edit
  end

  def update
    @post.update(posts_params)
    redirect_to posts_path
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice:"投稿を削除しました！"
  end

  def confirm
    @post = Post.new(posts_params)
    render :new if @post.invalid?
  end

  private
    def posts_params
      params.require(:post).permit(:title, :content)
    end

    def set_post
      @post = Post.find(params[:id])
    end
  
end
