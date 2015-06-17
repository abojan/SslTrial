class WorksController < ApplicationController
	before_action :correct_work,   only: :destroy

	def create
		# debugger
		@album = Album.find(params[:album_id])
		@work = @album.works.build(works_params)
		if @work.save
			flash[:success] = "Image Uploaded!"
			redirect_to album_path(@album)
		else
			flash[:warning] = "Image not-uploaded"
			redirect_to root_path
		end
	end	

		def destroy
			# debugger
			@work.destroy
			redirect_to album_path(@work.album_id)
		end

	private

		def works_params
			params.require(:work).permit(:picture)
		end

		def correct_work
			@work = Work.find_by(id: params[:id])
  		# @work = @album.works.find_by(id: params[:id])
  	end 
end
