module ApplicationHelper

  def full_title(page_title)
    base_title = "考试报名系统"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def get_name_by_paid(code)
    if code=="YES"  then ret="已缴"
      else ret="未缴费"
    end
     ret
  end

  def get_name_by_permission(code)
    unless code.nil?
     if code == "school_admin" then ret = "校管理员"
     elsif code == "academy_admin" then ret = "院管理员"
     elsif  code == "student_user" then ret = "学生用户"
     else ret = "其它"
     end
        ret
    end
    end

end
