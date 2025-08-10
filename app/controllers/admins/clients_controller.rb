class Admins::ClientsController < Admins::BaseController
	before_action :set_client, except: [:index, :new, :create]

  def index
    criteria = Client.where("company_name ILIKE ?", "%#{params[:search]}%")
    @clients = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
      format.js
    end
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params_client)
    if @client.save
      redirect_to admins_client_path(@client), :notice => "Successfully created client."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @client.update(params_client)
      redirect_to admins_client_path(@client), :notice  => "Successfully updated client."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @client.destroy
    redirect_to admins_clients_url, :notice => "Successfully destroyed client."
  end

  private

  def params_client
    params.require(:client).permit(:company_name, :image)
  end

	def set_client
		@client = Client.find(params[:id])
	end

end
