class Admins::SettingsController < Admins::BaseController
	before_action :set_setting, except: [:new, :create]

  def show
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(params_setting)
    if @setting.save
      redirect_to admins_setting_path, :notice => "Successfully created setting."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @setting.update(params_setting)
      redirect_to admins_setting_path, :notice  => "Successfully updated setting."
    else
      render :action => 'edit'
    end
  end

  private

  def params_setting
    params.require(:setting).permit(:admin_investor)
  end

	def set_setting
		@setting = Setting.first
	end

end
