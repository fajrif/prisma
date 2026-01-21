class Admins::InnovationsController < Admins::BaseController
  before_action :set_innovation, except: [:index, :new, :create]

  def index
    if params[:search].blank?
      criteria = Innovation.all
    else
      criteria = Innovation.where("title ->> :key ILIKE :value", key: I18n.locale.to_s, value: "%#{params[:search]}%")
    end

    @innovations = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @innovations }
      format.js
    end
  end

  def new
    @innovation = Innovation.new
  end

  def create
    @innovation = Innovation.new(params_innovation)
    if @innovation.save
      redirect_to admins_innovation_path(@innovation.id), :notice => "Successfully created innovation."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @innovation.update(params_innovation)
      redirect_to admins_innovation_path(@innovation.id), :notice  => "Successfully updated innovation."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @innovation.destroy
    redirect_to admins_innovations_url, :notice => "Successfully destroyed innovation."
  end

  private

  def params_innovation
    params.require(:innovation).permit(:title, :description, :icon, :link)
  end

  def set_innovation
    @innovation = Innovation.find(params[:id])
  end
end
