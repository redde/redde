class Admin::PhotosController < ActionController::Base

  def sort
    params[:photo].each_with_index do |id, idx|
      p = Photo.find(id)
      p.update(position: idx)
    end
    render nothing: true
  end

  def create
    if params[:product_id].present?
      parent = Product.find(params[:product_id])
    end       
    @photo = parent.photos.build(src: params[:file])
    unless @photo.save
      render js: 'alert("Ошибка! Фото не загружено")'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      render 'admin/photos/destroy'
    end
  end

end