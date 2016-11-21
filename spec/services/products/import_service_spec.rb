require 'spec_helper'

RSpec.describe Products::ImportService do
  let(:ids) { ['28806789'] }
  subject { described_class.call }

  context 'when id missed' do
    it 'raise exception' do
      expect {
        described_class.call
      }.to raise_error(ArgumentError)
    end
  end

  context 'with right args' do
    let(:remote_id) { 'XXXX' }
    subject { described_class.call(id: remote_id) }

    describe 'when product exists' do
      let(:name)  { 'name' }
      let(:price) { 10 }

      before do
        Product.where(remote_id: remote_id, name: name, price: price).create!
      end

      it 'not duplicates' do
        expect {
          subject
        }.to_not change(Product, :count)
      end
    end

    describe 'when product not exists' do
      let(:name)     { 'name' }
      let(:price)    { 10 }
      let(:attrs)    { { 'name' => name, 'salePrice' => price, 'numReviews' => 1 } }
      let(:response) { double(success?: true, parsed_response: attrs, code: 200) }

      before do
        # NOTE: issue in walmart gem. It supposts to return httparty_response.parsed_body
        # stub_request(:get, %r{walmartlabs.api.mashery.com/v1/items/#{remote_id}})
        #   .to_return(status: 200, body: {}.to_json)

        allow(HTTParty).to \
          receive(:get).and_return(response)
      end

      it 'saves product' do
        expect {
          subject
        }.to change(Product, :count).by(1)
      end

      describe 'when numReviews is 0' do
        let(:attrs) { { 'name' => name, 'salePrice' => price, 'numReviews' => 0 } }

        it 'not calls parser' do
          expect(Reviews::ImportService).to_not receive(:call)
          subject
        end
      end

      it 'calls reviews parser' do
        expect(Reviews::ImportService).to receive(:call).with(product_id: remote_id)
        subject
      end
    end
  end
end
