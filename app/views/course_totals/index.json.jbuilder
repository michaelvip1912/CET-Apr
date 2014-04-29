json.array!(@course_totals) do |course_total|
  json.extract! course_total, :course_encode, :course_name
  json.url course_total_url(course_total, format: :json)
end
