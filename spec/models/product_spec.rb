require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:remote_id) }
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
end
