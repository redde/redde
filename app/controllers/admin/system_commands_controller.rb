class Admin::SystemCommandsController < Admin::BaseController
  def index
  end

  def create
    return redirect_to [:admin, :system_commands], alert: 'Необходимо указать команду' unless params[:name].present?
    return redirect_to [:admin, :system_commands], notice: 'Недопустимый тип команды' unless allowed_command?
    SystemCommand.execute(params[:name])
    redirect_to [:admin, :system_commands], notice: 'Команда отправлена'
  end

  private

  def allowed_command?
    %w{cache unicorn sidekiq reboot}.include? params[:name]
  end
end
