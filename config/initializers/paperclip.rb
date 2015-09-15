options = Paperclip::Attachment.default_options
provider = ENV['PAPERCLIP_FOG_PROVIDER'] # Local, AWS, or nil for no fog

case
when "Local" == provider || Rails.env.test?
  options[:storage] = :fog
  options[:fog_credentials] = {
    provider: "Local",
    local_root: "#{Rails.root}/public"
  }
  options[:fog_directory] = ""
  options[:fog_host] = "http://localhost:3000"
  options[:path] = ":url"

when "AWS" == provider
  options[:storage] = :fog
  options[:fog_credentials] = {
    provider: 'AWS',
    #region: 'us-west-1',
  }
  # If not in ENV, leaving these keys unset allows them to be pulled
  # from ~/.fog.
  %w{aws_access_key_id aws_secret_access_key}.each do |k|
    val = ENV[k.upcase]
    options[:fog_credentials][k.to_sym] = val if val
  end
  options[:fog_directory] = ENV["PAPERCLIP_FOG_DIRECTORY"]
  # Avoid HTTPS due to connection setup overhead
  options[:fog_host] =
    "http://#{options[:fog_directory]}.s3.amazonaws.com"
  # Hrm... this does add a weird extra slash...
  options[:path] = ":url"

else
  # defaults: non-fog local storage
end
