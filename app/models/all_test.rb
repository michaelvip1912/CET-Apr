class AllTest < ActiveRecord::Base
  has_one :all_test_course
  has_many :sign_ups
  validates :description, presence: true

  def up_load_file=(up_file)
     self.attachment  = load_file(up_file)
   end


   def load_file(file)
     unless file.original_filename.empty?
       #生成一个随机的文件名
       @filename=get_file_name(file.original_filename)
       #向dir目录写入文件
       File.open("/public/load/#{@filename}", "wb") do |f|
         f.write(file.read)
       end
       #返回文件名称，保存到数据库中
          @filename
     end
   end

   def get_file_name(filename)
     unless filename.nil?
       #filename.sub(/.*./,rand.to_s+'.')
      Time.now.strftime("%Y%m%d%H%M%S")+'_'+filename
     end
   end
end
