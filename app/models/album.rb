class Album < ActiveRecord::Base
  belongs_to 			:user
  has_many        :works 
  validates 			:title, presence: true
  mount_uploader 	:picture, PictureUploader
  validate 				:picture_size

  private

  	#Validates the picture size 
  	def picture_size
  		if picture.size > 5.megabytes
  			errors.add(:picture, "less than 5MB")
  		end
  	end		
end
