class Admins::MemberTypesController < Admins::BaseController
	before_action :set_member_type, except: [:index, :new, :create]

  def index
    criteria = MemberType.all
    @member_types = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @member_types }
      format.js
    end
  end

  def show
  end

  def new
    @member_type = MemberType.new
  end

  def create
    @member_type = MemberType.new(params_member_type)
    if @member_type.save
			redirect_to admins_member_type_path(@member_type.id), :notice => "Successfully created member type."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @member_type.update(params_member_type)
			redirect_to admins_member_type_path(@member_type.id), :notice  => "Successfully updated member type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @member_type.destroy
    redirect_to admins_member_types_url, :notice => "Successfully destroyed member type."
  end

  private

  def params_member_type
    params.require(:member_type).permit(:name)
  end

	def set_member_type
		@member_type = MemberType.find(params[:id])
	end
end
