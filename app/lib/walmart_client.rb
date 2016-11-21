class WalmartClient
  extend SingleForwardable

  @client = WalmartOpen::Client.new do |config|
    ## Product API
    config.product_api_key = Rails.configuration.walmart_token

    # This value defaults to 5.
    config.product_calls_per_second = 4

    # Set this to true for development mode.
    config.debug = true
  end

  def_delegators :@client, :lookup
end
