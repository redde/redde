class Managers::RegistrationsController < Devise::RegistrationsController
  def new
    redirect_to root_path, alert: 'Регистрация закрыта'
  end

  def create
    redirect_to root_path, alert: 'Регистрация закрыта'
  end

  def edit
    redirect_to root_path, alert: 'Регистрация закрыта'
  end

  def update
    redirect_to root_path, alert: 'Регистрация закрыта'
  end

  def destroy
    redirect_to root_path, alert: 'Регистрация закрыта'
  end
end
