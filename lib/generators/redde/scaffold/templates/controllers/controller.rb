class Admin::<%= model_name.demodulize.pluralize -%>Controller < Admin::BaseController
  def index
    @<%= plural_resource_name %> = <%= model_name.demodulize -%>.all
  end
  <%- if column_names.include?('position') -%>
  def sort
    params[:pos].each_with_index do |id, idx|
      p = <%= model_name.demodulize -%>.find(id)
      p.update(position: idx)
    end
    render nothing: true
  end
  <%- end -%>

  def new
    @<%= resource_name %> = <%= model_name.demodulize -%>.new
    render 'edit'
  end

  def edit
    @<%= resource_name %> = <%= model_name.demodulize -%>.find(params[:id])
  end

  def create
    @<%= resource_name %> = <%= model_name.demodulize -%>.new(<%= resource_name %>_params)
    redirect_or_edit(@<%= resource_name %>, @<%= resource_name %>.save)
  end

  def update
    @<%= resource_name %> = <%= model_name.demodulize -%>.find(params[:id])
    redirect_or_edit(@<%= resource_name %>, @<%= resource_name %>.update(<%= resource_name %>_params))
  end

  def destroy
    @<%= resource_name %> = <%= model_name.demodulize -%>.find(params[:id])
    @<%= resource_name %>.destroy
    redirect_to admin_<%= plural_resource_name %>_path, notice: "#{<%= model_name.demodulize -%>.model_name.human} удален."
  end

  private

  def <%= resource_name %>_params
    params.require(:<%= resource_name %>).permit!
  end
end
