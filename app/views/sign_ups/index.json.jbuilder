json.array!(@sign_ups) do |sign_up|
  json.extract! sign_up, :student_no, :name, :gender
  json.url sign_up_url(sign_up, format: :json)
end
