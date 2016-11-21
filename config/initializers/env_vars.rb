%w(WALMART_TOKEN).each do |var|
  Rails.configuration.send("#{var.downcase}=", ENV.fetch(var))
end
