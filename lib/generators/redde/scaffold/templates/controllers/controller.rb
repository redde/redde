# coding: utf-8
class Admin::<%= plural_resource_name.capitalize -%>Controller < Admin::BaseController

  def index
    @<%= plural_resource_name %> = <%= resource_name.capitalize -%>.all
  end
  <%- if column_names.include?("position") -%>
  def sort
    params[:pos].each_with_index do |id, idx|
      p = <%= resource_name.capitalize -%>.find(id)
      p.position = idx
      p.save
    end
    render :nothing => true
  end
  <%- end -%>
  def new
    @<%= resource_name %> = <%= resource_name.capitalize -%>.new
    render 'edit'
  end

  def edit
    @<%= resource_name %> = <%= resource_name.capitalize -%>.find(params[:id])
  end

  def create
    @<%= resource_name %> = <%= resource_name.capitalize -%>.new(<%= resource_name %>_params)
    if @<%= resource_name %>.save
      redirect_to params[:commit] == "Применить" ? [:edit, :admin, @<%= resource_name %>] : [:admin, :<%= plural_resource_name %>], :notice => "#{<%= resource_name.capitalize -%>.model_name.human} добавлен."
    else
      render 'edit'
    end
  end

  def update
    @<%= resource_name %> = <%= resource_name.capitalize -%>.find(params[:id])
    if @<%= resource_name %>.update_attributes(<%= resource_name %>_params)
      redirect_to params[:commit] == "Применить" ? [:edit, :admin, @<%= resource_name %>] : [:admin, :<%= plural_resource_name %>], :notice => "#{<%= resource_name.capitalize -%>.model_name.human} отредактирован."
    else
      render 'edit'
    end
  end

  def destroy
    @<%= resource_name %> = <%= resource_name.capitalize -%>.find(params[:id])
    @<%= resource_name %>.destroy
    redirect_to admin_<%= plural_resource_name %>_path, :notice => "#{<%= resource_name.capitalize -%>.model_name.human} удален."
  end

  private
    def <%= resource_name %>_params
      params.require(:<%= resource_name %>).permit(<%= column_names.select {|c| !(['id', 'updated_at', 'created_at'].include? c) }.map {|c| ":#{c}"}.join(', ') %>)
    end

end