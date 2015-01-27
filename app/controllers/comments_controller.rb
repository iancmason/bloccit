class CommentsController < ApplicationController
  respond_to :html, :js

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

  def destroy
     @topic = Topic.find(params[:topic_id])
     @post = @topic.posts.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
 
     authorize @comment
     if @comment.destroy
       flash[:notice] = "Comment was removed."
       #redirect_to [@topic, @post]
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
       #redirect_to [@topic, @post]
     end
       respond_with(@comment) do |format|
       format.html { redirect_to [@post.topic, @post] }
       end
   end
end