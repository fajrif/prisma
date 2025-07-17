class Admins::Pages::SectionsController < Admins::BaseController
	before_action :set_page

	def new
		@section = @page.sections.build

    respond_to do |format|
      format.js { render :action => :form }
    end
	end

  def create
		@success = false
		@section = @page.sections.build(params_section)
    if @section.save
      flash[:notice] = "Successfully add section"
			@success = true
			set_sections
    end

    respond_to do |format|
      format.js { render :action => (@success == true ? :update : :form) }
    end
  end

	def edit
		@section = @page.sections.find(params[:id])

    respond_to do |format|
      format.js { render :action => :form }
    end
	end

  def update
		@success = false
		@section = @page.sections.find(params[:id])
    if @section.update(params_section)
      flash[:notice] = "Successfully update section"
			@success = true
    end

    respond_to do |format|
      format.js { render :action => (@success == true ? :update : :form) }
    end
  end

  def destroy
		@section = @page.sections.find(params[:id])
		@section.destroy
		set_sections
		flash[:notice] = "Section deleted."

    respond_to do |format|
      format.js { render :action => :update }
    end
  end

	def sort
		params[:section].each_with_index do |id, index|
			@page.sections.where(id: id).update_all(order_no: index + 1)
		end
		head :ok
	end

  private

  def params_section
    params.require(:section).permit(:page_id, :snippet_id, :order_no, :hidden, :bg_color, :css_class)
  end

	def set_page
		@page = Page.find(params[:page_id])
	end

	def set_sections
		@sections = @page.sections
	end

end
