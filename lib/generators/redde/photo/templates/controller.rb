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
    if params[:product_id].present?
      @product = Product.find(params[:product_id])
      @photo = @product.photos.build(src: params[:file])
    end       
    if @photo.save
      render layout: false
    else
      render js: 'alert("Ошибка! Фото не загружено")'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    render 'admin/photos/destroy'
  end

end