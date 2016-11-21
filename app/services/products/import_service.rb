module Products
  class ImportService
    include Interactor

    before do
      @id = context.id || raise(ArgumentError)
    end

    def call
      return if Product.where(remote_id: id).exists?

      # TODO
      # handle 5xx and 4xx from api

      save_product!
      save_reviews!
    end

    private

    attr_reader :id

    def save_product!
      Product
        .where(remote_id: id)
        .new(product_attributes)
        .save!
    end

    def save_reviews!
      review_count = product.raw_attributes.fetch('numReviews', 0)
      return unless review_count > 0

      # TODO
      # push to reviews queue
      Reviews::ImportService.call(product_id: id)
    end

    def product_attributes
      attributes = {
        name:  product.name,
        price: product.price
      }

      WalmartOpen::Item::API_ATTRIBUTES_MAPPING
        .values
        .each do |attr|
          next ['name', 'price'].include?(attr)

          attributes[:details][attr] = product.send(attr)
        end

      attributes
    end

    def product
      @product ||= WalmartClient.lookup(id)
    end
  end
end
