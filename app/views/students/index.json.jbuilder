json.array!(@students) do |student|
  json.extract! student, :student_no, :name, :grade, :id_number, :academy_encode, :professional_encode, :gender
  json.url student_url(student, format: :json)
end
