require 'rails_helper'

RSpec.describe Shopper, type: :model do
  let!(:shopper) { create(:shopper) }
  let(:id) { '1' }

  before do
    shopper.stub(:id).and_return(id)
    shopper.stub(:shopper_id).and_return(id)
  end
  # Association test
  # ensure Shopper model has a m:m relationship with the Categories and Search models
  it { expect have_many(:orders) }
  # Validation tests
  it { expect validate_uniqueness_of(:id) }
  it { expect validate_uniqueness_of(:shopper_id) }
end
