class Admin::PhotosController < ActionController::Base
  def sort
    params[:photo].each_with_index do |id, idx|
      p = Photo.find(id)
      p.update(position: idx)
    end
    render nothing: true
  end

  def create
    parent = Product.find(params[:product_id]) if params[:product_id].present?
    @photo = parent.photos.build(src: params[:file])
    render js: 'alert("Ошибка! Фото не загружено")' unless @photo.save
  end

  def destroy
    @photo = Photo.find(params[:id])
    render 'admin/photos/destroy' if @photo.destroy
  end
end
