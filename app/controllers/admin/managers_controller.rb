class Admin::ManagersController < Admin::BaseController
  helper_method :column_names

  def new
    @manager = scope.new
    render 'edit'
  end

  def create
    @manager = scope.new(manager_params)
    redirect_or_edit(@manager, @manager.save)
  end

  def edit
    @manager = scope.find(params[:id])
  end

  def update
    @manager = scope.find(params[:id])
    redirect_or_edit(@manager, @manager.update(manager_params))
  end

  def destroy
    @manager = scope.find(params[:id])
    @manager.destroy if current_manager.id != @manager.id
    redirect_to [:admin, :managers], alert: 'Администратор удален'
  end

  def column_names
    %w(email)
  end

  private

  def manager_params
    params[:manager].permit!
  end
end
