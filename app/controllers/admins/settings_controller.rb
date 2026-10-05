class Admins::SettingsController < Admins::BaseController
	before_action :set_setting

	# Company Profile: satu baris data yang dipakai schema Organization & WebSite
  def show
  end

  def edit
  end

  def update
    if @setting.update(params_setting)
      redirect_to admins_setting_path, :notice => "Successfully updated company profile."
    else
      render :action => 'edit'
    end
  end

  private

  def params_setting
    params.require(:setting).permit(:legal_name, :alternate_name, :founding_date, :email, :phone, :whatsapp,
																		:admin_contact, :description, :same_as_text, :logo)
  end

	def set_setting
		@setting = Setting.current
	end
end
