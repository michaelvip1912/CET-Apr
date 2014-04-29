class AddDataToAcademy < ActiveRecord::Migration
  def change
    Academy.delete_all
      Academy.create(:academy_encode => "001", :academy_name => "石油工程学院")
      Academy.create(:academy_encode => "002", :academy_name => "资源环境工程")
      Academy.create(:academy_encode => "003", :academy_name => "机电工程学院")
      Academy.create(:academy_encode => "004", :academy_name => "化学化工学院")
      Academy.create(:academy_encode => "005", :academy_name => "经济管理学院")
      Academy.create(:academy_encode => "006", :academy_name => "计算机科学学院")
      Academy.create(:academy_encode => "007", :academy_name => "电气信息学院")
      Academy.create(:academy_encode => "008", :academy_name => "材料科学与工程学院")
      Academy.create(:academy_encode => "009", :academy_name => "土木工程与建筑工程学院")
      Academy.create(:academy_encode => "010", :academy_name => "理学院")
      Academy.create(:academy_encode => "011", :academy_name => "外语学院")
      Academy.create(:academy_encode => "012", :academy_name => "政治学院")
      Academy.create(:academy_encode => "013", :academy_name => "文法学院")
      Academy.create(:academy_encode => "014", :academy_name => "体育系")
      Academy.create(:academy_encode => "015", :academy_name => "研究生部")
  end
end
