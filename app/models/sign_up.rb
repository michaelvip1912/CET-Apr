class SignUp < ActiveRecord::Base
  belongs_to :all_test
  validates :subject_1_encode, presence: true
  validates :tel, presence: true ,length:{is: 11}
  validates :class_name, presence: true
  validates :name, presence: true
  validates :student_no, presence: true
  validates :id_number, presence: true
  validates :grade, presence: true
  #validates :photo_url, presence: true
  #validates_format_of :photo_url,
  #                    :with => %r{\.(jpg|JPG)$}i,
  #                    :message => '必须为.jpg格式'


  def up_load_file=(up_file)
    self.photo_url=load_file(up_file)
  end


  def load_file(file)
    if !file.original_filename.empty?
      #生成一个随机的文件名
      @filename=get_file_name(file.original_filename)
      #向dir目录写入文件
      File.open("/public/photos/#{@filename}", "wb") do |f|
        f.write(file.read)
      end
      #返回文件名称，保存到数据库中
      @filename
    end
  end

  def get_file_name(filename)
    if !filename.nil?
      #filename.sub(/.*./,rand.to_s+'.')
      p student_no
       self.name + File.extname(filename)
    end
  end

  def file_delete(name)
    if File.exist?("#{File.dirname(__FILE__)}/#{name}")
      File.delete("#{File.dirname(__FILE__)}/#{name}")
    end
  end

end
