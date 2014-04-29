class AllTestsController < ApplicationController
  before_action :set_all_test, only: [:show, :edit, :update, :destroy]
  before_filter :admin_authorize ,:except => [:down_load_file]

  def down_load_file
      unless params[:id].nil?
        example = AllTest.find(params[:id])
        unless example.nil?
          send_file("/public/load/#{example.attachment}",:filename=>example.attachment , :disposition=>"inline")
        end
      else
        render :text=>"fileNotFound"
      end
  end

  def index
    @all_tests = AllTest.paginate(page: params[:page])
  end

  def show
    @one_test_course = AllTestCourse.find(:last,:conditions => [ 'all_test_id = ?', @all_test.id])

    rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid all_test #{params[:id]}")
    redirect_to :action => 'index'
  end

  def new
    @all_test = AllTest.new
    @courses=CourseTotal.all
  end

  def edit
    @courses=CourseTotal.all
  end

  def create
    @all_test = AllTest.new(all_test_params)

    respond_to do |format|
      if @all_test.save
        @selected = params[:selected]
        course_encode = @selected.join(";")
        all_test_course = AllTestCourse.new     #具体一次报名考试可以申报的所有课程
        all_test_course.all_test_id = @all_test.id
        all_test_course.course_encode = course_encode
        all_test_course.save
        format.html { redirect_to @all_test, notice: 'All test was successfully created.' }
        format.json { render action: 'show', status: :created, location: @all_test }
      else
        format.html { render action: 'new' }
        format.json { render json: @all_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /all_tests/1
  # PATCH/PUT /all_tests/1.json
  def update
    respond_to do |format|
      if @all_test.update(all_test_params)
        @selected=params[:selected]
        course_encode = @selected.join(";")
        all_test_course = AllTestCourse.find(:last,:conditions => [ 'all_test_id=?', @all_test.id])
        all_test_course.all_test_id = @all_test.id
        all_test_course.course_encode = course_encode
        all_test_course.save
        format.html { redirect_to @all_test, notice: 'All test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @all_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /all_tests/1
  # DELETE /all_tests/1.json
  def destroy
    @all_test_course = AllTestCourse.where("all_test_id = ?", @all_test.id).first
    @all_test_course.destroy
    @all_test.destroy
    respond_to do |format|
      format.html { redirect_to all_tests_url }
      format.json { head :no_content }
    end
  end

  private
    def set_all_test
      @all_test = AllTest.find(params[:id])
    end

    def all_test_params
      params.require(:all_test).permit(:test_date, :begin_date, :end_date, :description, :attachment)
    end
end
