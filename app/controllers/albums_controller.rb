class AlbumsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def show
    @album = Album.find(params[:id])
    @works = @album.works.all
    # debugger
    @work = @album.works.build
 
  end

  def create
   	@album = current_user.albums.build(album_params)
  	if @album.save
  		flash[:success] = "Album created!"
  		redirect_to current_user
  	else 
  		flash[:warning] = "Album not-created!"
  		redirect_to current_user
  	end 	
  end

  def destroy
   	@album.destroy
  	flash[:success] = "Successfully deleted..."
  	redirect_to request.referrer || current_user 	
  end

  private

  	def album_params
  		params.require(:album).permit(:title, :picture)
  	end

  	def correct_user
  		@album = current_user.albums.find_by(id: params[:id])
  	end  

end
