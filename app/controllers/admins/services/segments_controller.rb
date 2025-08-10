class Admins::Services::SegmentsController < Admins::BaseController
	before_action :set_service

	def new
		@segment = @service.segments.build

    respond_to do |format|
      format.js { render :action => :form }
    end
	end

  def create
		@success = false
		@segment = @service.segments.build(params_segment)
    if @segment.save
      flash[:notice] = "Successfully add segment"
			@success = true
			set_segments
    end

    respond_to do |format|
      format.js { render :action => (@success == true ? :update : :form) }
    end
  end

	def edit
		@segment = @service.segments.find(params[:id])

    respond_to do |format|
      format.js { render :action => :form }
    end
	end

  def update
		@success = false
		@segment = @service.segments.find(params[:id])
    if @segment.update(params_segment)
      flash[:notice] = "Successfully update segment"
			@success = true
    end

    respond_to do |format|
      format.js { render :action => (@success == true ? :update : :form) }
    end
  end

  def destroy
		@segment = @service.segments.find(params[:id])
		@segment.destroy
		set_segments
		flash[:notice] = "Segment deleted."

    respond_to do |format|
      format.js { render :action => :update }
    end
  end

	def sort
		params[:segment].each_with_index do |id, index|
			@service.segments.where(id: id).update_all(order_no: index + 1)
		end
		head :ok
	end

  private

  def params_segment
    params.require(:segment).permit(:service_id, :snippet_id, :order_no, :hidden, :bg_color, :css_class)
  end

	def set_service
		@service = Service.find(params[:service_id])
	end

	def set_segments
		@segments = @service.segments
	end

end
