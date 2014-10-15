class Admin::PhotosController < ActionController::Base

  def sort
    params[:photo].each_with_index do |id, idx|
      p = Photo.find(id)
      p.position = idx
      p.save
    end
    render :nothing => true
  end

  def create
    parent = photo_params[:imageable_type].constantize.find(photo_params[:imageable_id])
    @photo = parent.photos.build(photo_params)     
    if @photo.save
      render(partial: "photo", object: @photo)
    else
      render nothing: true, status: 422
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    render 'admin/photos/destroy'
  end

  private

    def photo_params
      params.require(:photo).permit!
    end

end