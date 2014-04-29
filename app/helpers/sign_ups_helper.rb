module SignUpsHelper
  def options_for_select_years
    t=Time.now
    t.year
    str_year=t.strftime('%Y')
    year=Integer(str_year)
    years = Hash.new
    (year-5..year+1).each { |i| years.store(i.to_s+"年", i.to_s[2,3]) } #循环赋值给hash
    p years
    years=years.sort{|a,b| a[1] <=> b[1]}  #hash的排序，排序方法不明。后面是倒转，含义不明
    options_for_select(years,year.to_s)
  end

  def options_for_select_grade
     t=Time.now
     t.year
     str_year=t.strftime('%Y')
     year=Integer(str_year)
     years = Hash.new
     (year-5..year+1).each { |i| years.store(i.to_s+"级", i.to_s[2,3]) } #循环赋值给hash
     p years
     years=years.sort{|a,b| a[1] <=> b[1]}  #hash的排序，排序方法不明。后面是倒转，含义不明
     options_for_select(years,year.to_s)
   end
end
