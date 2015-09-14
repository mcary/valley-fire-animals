json.array!(@reports) do |report|
  json.extract! report, :id, :summary, :description, :report_type, :reporter_name, :reporter_contact_info
  json.url report_url(report, format: :json)
end
