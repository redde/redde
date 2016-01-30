class Admin::SystemCommandsController < Admin::BaseController
  def index
  end

  def update
    return redirect_to [:admin, :system_commands], alert: 'Необходимо указать команду' unless params[:id].present?
    return redirect_to [:admin, :system_commands], notice: 'Недопустимый тип команды' unless Redde::SystemCommand::ALLOWED_ACTIONS.include?(params[:id].to_s)
    Redde::SystemCommand.execute(params[:id])
    redirect_to [:admin, :system_commands], notice: 'Команда отправлена'
  end
end
