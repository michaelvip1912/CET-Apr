json.array!(@all_tests) do |all_test|
  json.extract! all_test, :test_date, :begin_date, :end_date, :description, :attachment
  json.url all_test_url(all_test, format: :json)
end
