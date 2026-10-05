class Admins::SchemaMarkupsController < Admins::BaseController
	before_action :set_schema_markup, except: %i[index new create schemable_records]

  def index
    criteria = SchemaMarkup.where("name ILIKE :q OR schema_type ILIKE :q OR path_pattern ILIKE :q",
																	q: "%#{params[:search]}%")
    @schema_markups = criteria.page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @schema_markups }
      format.js
    end
  end

  def show
  end

	# Mengisi ulang dropdown record ketika tipe model diganti (dipanggil form via AJAX)
	def schemable_records
		@objectables = allowed_types.include?(params[:type].to_s) ? params[:type].constantize.all : []

		respond_to do |format|
			format.js
		end
	end

  def new
    @schema_markup = SchemaMarkup.new(schema_type: params[:schema_type])
		set_objectables
  end

  def create
    @schema_markup = SchemaMarkup.new(params_schema_markup)
    if @schema_markup.save
      redirect_to admins_schema_markup_path(@schema_markup), :notice => "Successfully created schema."
    else
			set_objectables
      render :action => 'new'
    end
  end

  def edit
		set_objectables
  end

  def update
    if @schema_markup.update(params_schema_markup)
      redirect_to admins_schema_markup_path(@schema_markup), :notice  => "Successfully updated schema."
    else
			set_objectables
      render :action => 'edit'
    end
  end

  def destroy
    @schema_markup.destroy
    redirect_to admins_schema_markups_url, :notice => "Successfully destroyed schema."
  end

  private

  def params_schema_markup
    params.require(:schema_markup).permit(:name, :scope_type, :schemable_type, :schemable_id, :path_pattern,
																					:schema_type, :body, :status, :order_no)
  end

	def set_schema_markup
		@schema_markup = SchemaMarkup.find(params[:id])
	end

	def allowed_types
		helpers.get_schema_markup_objects
	end

	# Pilihan record untuk scope "record", mengikuti pola Admins::LinkButtonsController#objectable_types
	def set_objectables
		type = @schema_markup.schemable_type.presence || allowed_types.first
		@objectables = allowed_types.include?(type) ? type.constantize.all : []
	end
end
