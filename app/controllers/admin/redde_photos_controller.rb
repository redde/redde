class Admin::ReddePhotosController < ActionController::Base
  def sort
    params[:photo].each_with_index do |id, idx|
      p = Redde::Photo.find(id)
      p.update(position: idx)
    end
    render nothing: true
  end

  def create
    if photo_params[:imageable_id].present?
      parent = photo_params[:imageable_type].constantize.find(photo_params[:imageable_id])
      @photo = parent.photos.build(photo_params)
    else
      @photo = Redde::Photo.new(photo_params)
    end
    if @photo.save
      render(partial: 'photo', object: @photo)
    else
      render nothing: true, status: 422
    end
  end

  def destroy
    @photo = Redde::Photo.find(params[:id])
    @photo.destroy
    render 'admin/redde_photos/destroy'
  end

  private

  def photo_params
    params.require(:redde_photo).permit!
  end
end
