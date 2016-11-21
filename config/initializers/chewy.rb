Chewy.root_strategy = :urgent
Chewy.logger = Rails.logger

case Rails.env
when 'staging', 'production'
  Chewy.settings = { host: ENV.fetch('SEARCHBOX_URL') }
  Chewy.root_strategy = :resque
when 'test'
  Chewy.settings = { host: ENV.fetch('ELASTICSEARCH_URL'), prefix: 'test' }
else
  Chewy.settings = { host: ENV.fetch('ELASTICSEARCH_URL') }
end
