class CommentsController < ApplicationController
  def index
    @comments = Comment.all 
    render json: @comments
  end

  def new
    @comment = Comment.new
    @user = current_user
  end

  def create
    @comment = Comment.new(comment_params)
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    if @comment.save
      @user.comments << @comment
      @post.comments << @comment
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
    @comment = Comment.find(params[:id])
    user_id = @comment.user_id
    @user = User.find(user_id)
  end

  def edit
    @current_user = current_user
    if @current_user.id = params[:user_id]
      @comment = Comment.find(params[:id])
      puts @comment
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    redirect_to user_path
  end

  private
    def find_user
      @user = User.find(params[:user_id])
    end

    def find_comment
      @comment = Comment.find(params[:id])
    end
    
    def comment_params 
      params.require(:comment).permit(:body)
    end
end
