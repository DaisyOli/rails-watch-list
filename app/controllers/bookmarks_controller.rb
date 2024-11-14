class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = @list.bookmarks.new(bookmark_params)

    if @bookmark.save
      redirect_to list_path(@list), notice: "Bookmark created!"
    else
      flash.now[:alert] = "There was an error creating the bookmark."
      render "lists/show"
    end
  end

  def destroy
    @list = List.find_by(id: params[:list_id]) # Utilise find_by pour éviter une exception si non trouvé
    @bookmark = @list&.bookmarks.find(params[:id]) if @list # Récupère le bookmark si la liste est trouvée
  
    if @bookmark
      @bookmark.destroy
      redirect_to list_path(@list), status: :see_other
    else
      redirect_to lists_path, alert: "List or Bookmark not found."
    end
  end
  

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
