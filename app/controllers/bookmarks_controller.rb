class BookmarksController < ApplicationController

  def new
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])  # Trouve la `list` parente
    @bookmark = @list.bookmarks.new(bookmark_params)  # Crée un nouveau `bookmark` associé à la `list`
  
    if @bookmark.save
      redirect_to list_path(@list), notice: "Bookmark created!"
    else
      render :new # Affiche le formulaire `new` si sauvegarde échoue
    end
  end
  
  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
