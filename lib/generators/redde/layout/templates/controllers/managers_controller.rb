class Admin::ManagersController < Admin::BaseController
  def index
    @managers = Manager.all
  end

  def new
    @manager = Manager.new
    render 'edit'
  end

  def create
    @manager = Manager.new(manager_params)
    redirect_or_edit(@manager, @manager.save)
  end

  def edit
    @manager = Manager.find(params[:id])
  end

  def update
    @manager = Manager.find(params[:id])
    redirect_or_edit(@manager, @manager.update(manager_params))
  end

  def destroy
    @manager = Manager.find(params[:id])
    @manager.destroy if current_manager.id != @manager.id
    redirect_to [:admin, :managers], alert: 'Администратор удален'
  end

  private

  def manager_params
    params[:manager].permit!
  end
end
