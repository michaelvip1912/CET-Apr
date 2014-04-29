class CourseTotalsController < ApplicationController
  before_action :set_course_total, only: [:show, :edit, :update, :destroy]
  before_filter :admin_authorize

  def index
    @course_totals = CourseTotal.paginate(page: params[:page])
  end

  def show
  end

  def new
    @course_total = CourseTotal.new
  end

  def edit
  end

  def create
    @course_total = CourseTotal.new(course_total_params)

    respond_to do |format|
      if @course_total.save
        format.html { redirect_to @course_total, notice: 'Course total was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course_total }
      else
        format.html { render action: 'new' }
        format.json { render json: @course_total.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course_total.update(course_total_params)
        format.html { redirect_to @course_total, notice: 'Course total was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course_total.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course_total.destroy
    respond_to do |format|
      format.html { redirect_to course_totals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_total
      @course_total = CourseTotal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_total_params
      params.require(:course_total).permit(:course_encode, :course_name)
    end
end
