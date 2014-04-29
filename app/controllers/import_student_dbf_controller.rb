class ImportStudentDbfController < ApplicationController
  before_filter :admin_authorize

  #读取文件配置
  def read_refer
    refers=[]
    refers<<['student_no', '学号', 'XH']
    refers<<['name', '姓名', 'XM']
    refers<<['gender', '性别码', 'XBDM']
    refers<<['id_number', '身份证号', 'ZJHM']
    refers<<['academy_encode', '学院', 'YXSDM']
    refers<<['professional_encode', '专业', 'ZYDM']
    refers
  end


  def  preview
    unless params[:file_name].blank?
      @file_name=params[:file_name]
      table=DBF::Table.new("/public/upLoadFile/#{@file_name}")
      columns=table.columns.map { |u| u.name.upcase }
      if params[:refers]
        @refers=read_refer
        params[:refers].each do |para_refer|
          @refers.each do |refer|
            if para_refer[0]== refer[0]
              refer[2]=para_refer[1]
            end
          end
        end
      else
        #若爲第一次，則直接讀取原始數據
        @refers=read_refer
        #生成对应关系
        @refers.each do |refer|
          if columns.include?(refer[0])
            refer[2]=refer[0]
          end
        end
      end

      @options_refers=[]
      @options_refers<<''
      columns.each do |field|
        @options_refers <<field.to_s
      end

      #若核对无误则保存到数据库中
      if !params[:commit].blank?
        if params[:commit]=='导入到学生库'
          table.each do |record|
           student=Student.new
            @refers.each do |refer|
              unless refer[2].blank?
                t=Iconv.iconv('UTF-8', 'gb18030', record.attributes[refer[2]].to_s)
                #写入到学生记录对应的字段中
                student.write_attribute(refer[0], t[0])
               end
            end

            student.grade=student.student_no[0, 4]
           if Student.find_by_student_no(student.student_no).nil?
            student.save
            user= User.new
            user.encode =student.student_no
            user.name = student.name
            user.academy_encode =student.academy_encode
            user.permission="student_user"
            user.password=student.id_number[12,17]
            user.password_confirmation= student.id_number[12,17]
            user.save
           end
           end

          redirect_to students_path
          return
        end
      end


      #存储读出的学生信息数组
      @students=[]
      record_count=0
      table.each do |record|
        student=Student.new
        @refers.each do |refer|
          unless refer[2].blank?
            t=Iconv.iconv('UTF-8', 'gb18030', record.attributes[refer[2]].to_s)
            #写入到学生记录对应的字段中
            student.write_attribute(refer[0], t)
          end
        end
        @students << student
        record_count +=1
        if record_count ==3
          break
        end
      end
    end
  end

  def up_load_file(file)
    if !file.original_filename.empty?
      @filename=get_file_name(file.original_filename)
      File.open("#{RAILS_ROOT}/public/upLoadFile/#{@filename}", 'wb') do |f|
        f.write(file.read)
      end
      @filename
    end
  end

  def get_file_name(filename)
    if !filename.nil?
      Time.now.strftime('%Y_%m_%d_%H_%M_%S') + '_' + filename
    end
  end

  def save
    unless request.get?
      if params[:file]
        name=params[:file]['file'].original_filename
        if !name.downcase.include?('.dbf')
          render :text => '必须是DBF文件'
          return
        end
        if filename=up_load_file(params[:file]['file'])
          redirect_to preview_import_student_dbf_path(:file_name => filename)
          return
        end
      end
      render :text => '必须选择一个DBF文件'
    end
  end
  def index
  end
end
