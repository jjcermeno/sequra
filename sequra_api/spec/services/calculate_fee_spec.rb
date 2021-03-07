describe CalculateFee do
  context 'get fee for 49 €' do
    it 'fee is 49 * 0.01 = 0.49' do
      calculator = CalculateFee.new
      result = calculator.call(49)
      expect(result).to eq(0.49)
    end
  end
  context 'get fee for 51 €' do
    it 'fee is 51 * 0.095 = 0.4845' do
      calculator = CalculateFee.new
      result = calculator.call(51)
      expect(result).to eq(0.4845)
    end
  end
  context 'get fee for 301 €' do
    it 'fee is 301 * 0.0085 = 2.5585' do
      calculator = CalculateFee.new
      result = calculator.call(301)
      expect(result).to eq(2.5585)
    end
  end
end
