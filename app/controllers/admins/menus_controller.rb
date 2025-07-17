class Admins::MenusController < Admins::BaseController
	before_action :set_menu, except: [:index, :new, :create]

  def index
    @menus = Menu.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @menus }
      format.js
    end
  end

  def show
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(params_menu)
    if @menu.save
			redirect_to admins_menu_path(@menu), :notice => "Successfully created menu."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @menu.update(params_menu)
			redirect_to admins_menu_path(@menu), :notice  => "Successfully updated menu."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @menu.destroy
    redirect_to admins_menus_url, :notice => "Successfully destroyed menu."
  end

  private

  def params_menu
    params.require(:menu).permit(:data, :section)
  end

	def set_menu
		@menu = Menu.find(params[:id])
	end
end
