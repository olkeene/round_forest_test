namespace :application do
  task fetch_products: :environment do
    # NOTE: turn into daemon mode
    loop do
      p 'processing products...'
      Queues::ProductsService.call

      p 'sleeping 10 secs...'
      sleep 10 # secs
    end
  end
end
