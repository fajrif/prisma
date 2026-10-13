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

  # Identitas resmi (nama dagang, badan hukum, tahun berdiri, anak perusahaan) diubah lewat
  # langkah terpisah dengan peringatan risiko, bukan dari form utama.
  def identity
    @setting.assign_attributes(params_identity)
    if params[:confirm_risk] != '1'
      @setting.errors.add(:base, 'Centang pernyataan bahwa Anda memahami risikonya sebelum menyimpan.')
    elsif @setting.save(context: :identity)
      return redirect_to admins_setting_path, :notice => "Identitas resmi perusahaan berhasil diperbarui."
    end
    @open_identity_modal = true
    render :action => 'edit'
  end

  private

  def params_setting
    params.require(:setting).permit(:email, :phone, :whatsapp, :admin_contact, :description, :same_as_text, :logo,
																		:alternate_names_text, :knows_about_text, :area_served_text, :contact_points_text)
  end

  def params_identity
    params.require(:setting).permit(:brand_name, :legal_name, :founding_year, :sub_organizations_text)
  end

	def set_setting
		@setting = Setting.current
	end
end
