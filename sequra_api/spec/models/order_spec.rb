require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order) { build(:order) }
  let(:id) { '1' }

  before do
    order.stub(:id).and_return(id)
    order.stub(:order_id).and_return(id)
  end
  # Association test
  # ensure Merchant model has a m:m relationship with the Categories and Search models
  it { expect belong_to(:merchant) }
  it { expect belong_to(:shopper) }
  # Validation tests
  it { expect validate_uniqueness_of(:id) }
  it { expect validate_uniqueness_of(:order_id) }
  it { expect(order.week).to eq(8)}
  it { expect(order.year).to eq(2021)}
  it { expect(order.completed).to eq(true)}
end
