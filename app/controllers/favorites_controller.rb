class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite
    

    if favorite.save
      flash[:notice] = "Post favorited was totally successful."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Yo, there was an error with favoriting."
      redirect_to [@post.topic, @post]
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    favorite = @post.favorites.find(params[:id])
    authorize favorite

    if favorite.destroy
      flash[:notice] = "Unfavoriting successful."
      redirect_to :back
    else
      flash[:error] = "Error with unfavoriting."
      redirect_to :back
    end    
  end
end