class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments


    @comment = current_user.comments.build(params[:comment].permit!)
    @comment.post = @post

    # authorize! :create, @comment, message: "Sign in to make comment buddy"
    if @comment.save
      flash[:notice] = "Comment has been added."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Error creating comment. Please try again."
      render 'posts/show'
    end
  end
end