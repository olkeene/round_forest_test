module Queues
  class ProductsService
    include Interactor

    # Read Queue...
    def call
      each_id do |id|
        Products::ImportService.call(id: id)
      end
    end

    private

    def each_id(&_block)
      each_url_in_queue do |url|
        # NOTE: not the best way, but fine for proto
        yield url.split('/').last
      end
    end

    def each_url_in_queue(&_block)
      [
        'https://www.walmart.com/ip/Ematic-9-Dual-Screen-Portable-DVD-Player-with-Dual-DVD-Players-ED929D/28806789'
      ].each { |url| yield url }
    end
  end
end
