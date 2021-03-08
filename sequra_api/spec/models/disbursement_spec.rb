require 'rails_helper'

RSpec.describe Disbursement, type: :model do
  let!(:disbursement) { build(:disbursement) }
  let(:id) { '1' }

  before do
    disbursement.stub(:id).and_return(id)
  end
  # Association test
  # ensure Merchant model has a m:m relationship with the Categories and Search models
  it { expect belong_to(:merchant) }
  it { expect belong_to(:order) }
  # Validation tests
  it { expect validate_uniqueness_of(:id) }
  it { expect(disbursement.week).to eq(8)}
  it { expect(disbursement.year).to eq(2021)}
end
