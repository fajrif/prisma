class Admins::MembersController < Admins::BaseController
	before_action :set_member, except: [:index, :new, :create]

  def index
    criteria = Member.where("full_name ILIKE ?", "%#{params[:search]}%")

		unless params[:member_type_id].blank?
			criteria = criteria.where("member_type_id = ?", "#{params[:member_type_id]}")
		end

    @members = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
      format.js
    end
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(params_member)
    if @member.save
			redirect_to admins_member_path(@member.id), :notice => "Successfully created member."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @member.update(params_member)
			redirect_to admins_member_path(@member.id), :notice  => "Successfully updated member."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @member.destroy
    redirect_to admins_members_url, :notice => "Successfully destroyed member."
  end

  private

  def params_member
    params.require(:member).permit(:order_no, :full_name, :job_title, :description, :content, :photo, :member_type_id)
  end

  def set_member
		@member = Member.find(params[:id])
  end
end
