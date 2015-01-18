class PostsController < ApplicationController
  def show
    # @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @topic = @post.topic
    @comments = @post.comments
    @comment = Comment.new
    @post = Post.find(params[:id])

  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post

    if @post.save
        @post.create_vote
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    #@post = Post.find(params[:id])
    #refactored code example 1
    @post = current_user.posts.build(post_params)
    authorize @post

    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def destroy
     @topic = Topic.find(params[:topic_id])
     @post = Post.find(params[:id])
     title = @post.title
     authorize @post
 
     if @post.destroy
       flash[:notice] = "\"#{title}\" was deleted successfully."
       redirect_to @topic
     else
       flash[:error] = "There was an error deleting the post."
       render :show
     end
   end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end