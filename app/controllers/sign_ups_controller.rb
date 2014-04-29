class SignUpsController < ApplicationController
  before_action :set_sign_up, only: [:show, :edit, :update, :destroy]
  before_filter :admin_authorize, :except => [:show, :my_sign_ups, :new]

  def index
    if current_user.permission == "school_admin"
       @sign_ups = SignUp.paginate(page: params[:page]).order("all_test_id DESC")
    elsif
       current_user.permission == "academy_admin"
      @sign_ups = SignUp.where("academy_encode = ?",
                        current_user.academy_encode).paginate(page: params[:page]).order("all_test_id DESC")
    end
  end

  def last_test
    last_test = AllTest.last
    unless last_test.nil?
      if current_user.permission == "school_admin"
         @sign_ups = SignUp.where("all_test_id = ? ",
                            last_test.id).paginate(page: params[:page]).order("student_no ASC")
      elsif
         current_user.permission == "academy_admin"
         @sign_ups = SignUp.where("all_test_id = ? and academy_encode = ?",
                            last_test.id, current_user.academy_encode
                            ).paginate(page: params[:page]).order("student_no ASC")
      end
    end
  end

  def all_test
    @all_tests = AllTest.all
  end

  def every_test
    @all_test = AllTest.find(params[:id])
    if current_user.permission == "school_admin"
       @sign_ups = SignUp.where("all_test_id = ? ",
                                @all_test.id).paginate(page: params[:page]).order("student_no ASC")
    elsif
       current_user.permission == "academy_admin"
       @sign_ups = SignUp.where("all_test_id = ? and academy_encode = ?",
                                @all_test.id, current_user.academy_encode
                                ).paginate(page: params[:page]).order("student_no ASC")
    end
  end

  def my_sign_ups
    @sign_ups = SignUp.where("student_no = ?",
                             current_user.encode).paginate(page: params[:page]).order("all_test_id DESC")
  end

  def show
  end

  def new
    if current_user.nil?
       redirect_to :controller => 'sessions', :action => 'new'
       return
    end
     student = Student.where("student_no = ?", current_user.encode).first
     last_test_course = AllTestCourse.last
     @choose = last_test_course.course_encode.split(";")
     @sign_up = SignUp.where("student_no = ?", current_user.encode).last

     if @sign_up.nil? || !(@sign_up.all_test_id == last_test_course.all_test_id)
       @sign_up = SignUp.new
       @sign_up.name = student.name
       @sign_up.student_no = student.student_no
       @sign_up.gender = student.gender
       @sign_up.id_number = student.id_number
       @sign_up.grade = student.grade
       @sign_up.academy_encode = student.academy_encode
       @sign_up.professional_encode = student.professional_encode
     else
       redirect_to @sign_up
     end
  end

  def edit
  end


  def create
    last_test_course = AllTestCourse.last
       sign_up = SignUp.where('all_test_id = ? and student_no = ?',
                              last_test_course.all_test_id, current_user).first
       if sign_up.nil?
         @sign_up = SignUp.new(sign_up_params)
         @sign_up.all_test_id = last_test_course.all_test_id

         if params[:sub]
         @subjects = params[:sub]
         @sign_up.subject_1_encode = @subjects[0] if @subjects[0]
         @sign_up.subject_2_encode = @subjects[1] if @subjects[1]
         @sign_up.subject_3_encode = @subjects[2] if @subjects[2]
         @sign_up.subject_4_encode = @subjects[3] if @subjects[3]
         end

    respond_to do |format|
      if @sign_up.save
        format.html { redirect_to @sign_up, notice: 'Sign up was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sign_up }
      else
        format.html { render action: 'new' }
        format.json { render json: @sign_up.errors, status: :unprocessable_entity }
      end
    end
       else
         redirect_to sign_up
    end
  end

  def update
    respond_to do |format|
      if @sign_up.update(sign_up_params)
        format.html { redirect_to @sign_up, notice: 'Sign up was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sign_up.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sign_up.destroy
    respond_to do |format|
      format.html { redirect_to sign_ups_url }
      format.json { head :no_content }
    end
  end
  
  def compress
    if File.exist?("/public/photos.zip")
      File.delete("/public/photos.zip")
    end
    Zip::ZipFile.open "/public/photos.zip", Zip::ZipFile::CREATE do |zip|
      add_file_to_zip(zip)
    end
    send_file("/public/photos.zip", :disposition=>'inline', :filename=>'photos.zip')

  end

  def add_file_to_zip(zip)
    @last_test = AllTest.find(:last)
    unless @last_test.nil?
    @sign_ups = SignUp.where('all_test_id = ?', @last_test.id).first
    end
    unless @sign_ups.nil?
    @sign_ups.each do |sub_file_name|
      if File.exist?("public/photos/#{sub_file_name.photo_url}")
        zip.add("photos/#{sub_file_name.student_no}.jpg", "public/photos/#{sub_file_name.photo_url}") unless sub_file_name.photo_url == '.' or sub_file_name.photo_url == '..'
      end
      end
    end
  end


  def to_excel
    tmp = Tempfile.new('tmp', "/public/reports")
    workbook = Spreadsheet::Excel.new("#{tmp.path}")
    worksheet = workbook.add_worksheet('CET报名表')
    i=1
    all_test=AllTest.find(:last)
    if current_user.permission == "1"
      sign_ups=SignUp.where("all_test_id = ?", all_test.id).order("student_no ASC")
    elsif  user.permission == "2"
      sign_ups=SignUp.where("all_test_id=? and academy_encode = ?",
                            all_test.id,current_user.academy_encode).order("student_no ASC")
    end
    sign_ups.each do |s|
      worksheet.write(i, 0, '')
      worksheet.write(i, 1, s.name)
      worksheet.write(i, 2, s.gender)
      worksheet.write(i, 3, s.student_no)
      worksheet.write(i, 4, s.id_type)
      worksheet.write(i, 5, s.id_number)
      worksheet.write(i, 6, s.education)
      worksheet.write(i, 7, s.education_len)
      worksheet.write(i, 8, s.grade)
      worksheet.write(i, 9, s.academy_encode)
      worksheet.write(i, 10, s.professional_encode)
      worksheet.write(i, 11, s.class_name)
      worksheet.write(i, 12, s.tel)
      worksheet.write(i, 13, s.subject_1_encode)
      worksheet.write(i, 14, s.subject_2_encode)
      worksheet.write(1, 15, s.subject_3_encode)
      worksheet.write(1, 16, s.subject_4_encode)
      i=i+1
    end


    workbook.close
    send_file(tmp.path, :disposition => 'inline', :filename => "CET报名表 #{1.day.ago.strftime('%Y-%m-%d')}"+'.xls')
    tmp.close(false)
  end


  private

    def set_sign_up
      @sign_up = SignUp.find(params[:id])
    end

    def sign_up_params
      params.require(:sign_up).permit(:student_no, :name, :gender, :id_type,
                                      :id_number, :grade, :academy_encode,
                                      :professional_encode, :education_len,
                                      :education, :class_name, :tel, :photo_url,
                                      :subject_1_encode, :subject_2_encode,
                                      :subject_3_encode, :subject_4_encode)

    end
end
