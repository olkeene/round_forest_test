require 'spec_helper'

RSpec.describe Queues::ProductsService do
  let(:ids) { ['28806789'] }
  subject { described_class.call }

  it 'expects to call Products::ImportService with right ids' do
    ids.each do |id|
      expect(Products::ImportService).to receive(:call).with(id: id)
    end

    subject
  end
end
