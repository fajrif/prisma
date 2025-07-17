class Admins::SnippetsController < Admins::BaseController
	before_action :set_snippet, except: [:index, :new, :create]

  def index
    criteria = Snippet.where("name ILIKE :value or (title ->> :key ILIKE :value)", key: I18n.locale.to_s, value: "%#{params[:search]}%")
    @snippets = criteria.page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @snippets }
      format.js
    end
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(params_snippet)
    if @snippet.save
      redirect_to admins_snippet_path(@snippet), :notice => "Successfully created snippet."
    else
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @snippet.update(params_snippet)
      redirect_to admins_snippet_path(@snippet), :notice  => "Successfully updated snippet."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @snippet.destroy
    redirect_to admins_snippets_url, :notice => "Successfully destroyed snippet."
  end

	def delete_attachment
		if @asset = ActiveStorage::Attachment.find(params[:asset_id])
			flash[:notice] = "Successfully delete image."
			@snippet.image.purge
		end
		redirect_to admins_snippet_path(@snippet)
	end

  private

  def params_snippet
    params.require(:snippet).permit(:image, :background, :name, :title, :caption, :short_description, :description, :title_tag, :text_color, :template, :bg_color, :css_class, :css_title, :css_desc, :orientation, :video_url, :parent_id)
  end

	def set_snippet
		@snippet = Snippet.find(params[:id])
	end

	def set_objectables
		@objectables = []
		if @snippet.is_object_route?
			@objectables = @snippet.objectable.class.all
		end
	end
end
