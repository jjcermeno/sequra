require 'rails_helper'

RSpec.describe Merchant, type: :model do
  let!(:merchant) { create(:merchant) }
  let(:id) { '1' }

  before do
    merchant.stub(:id).and_return(id)
    merchant.stub(:merchant_id).and_return(id)
  end
  # Association test
  # ensure Merchant model has a m:m relationship with the Categories and Search models
  it { expect have_many(:orders) }
  it { expect have_many(:disbursements) }
  # Validation tests
  it { expect validate_uniqueness_of(:id) }
  it { expect validate_uniqueness_of(:merchant_id) }
end
