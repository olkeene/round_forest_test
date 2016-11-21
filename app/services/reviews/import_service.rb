module Reviews
  class ImportService
    include Interactor

    PER_PAGE = 20
    URL = "https://www.walmart.com/reviews/api/product/%{id}?page=%{page}&limit=#{PER_PAGE}".freeze

    before do
      @product_id = context.product_id || raise(ArgumentError)
    end

    def call
      # TODO: handle exceptions
      save_reviews!
    end

    private

    attr_reader :product_id

    def save_reviews!
      product.update_attributes! reviews: reviews
    end

    def reviews
      # TODO
      # navigate by pages
      body = Nokogiri::HTML(response_body)
      raw_reviews = body.xpath('//div[@class="Grid customer-review js-customer-review"]')
      return [] if !raw_reviews || raw_reviews.empty?

      raw_reviews.map do |raw_review|
        author = raw_review.at_xpath('.//span[@class="js-nick-name customer-name-heavy"]').text.strip
        text   = raw_review.at_xpath('.//div[@class="customer-review-text"]').text.strip

        {
          author: author,
          text:   text
        }
      end
    end

    def product
      Product.where(remote_id: product_id).first!
    end

    def url(page)
      URL % { id: product_id, page: page }
    end

    def response_body(page = 1)
      HTTParty
        .get(url(page))
        .parsed_response['reviewsHtml']
    end
  end
end
