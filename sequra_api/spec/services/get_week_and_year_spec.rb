describe GetWeekAndYear do
  context 'get week for first day of year 2021' do
    it 'week is 53 year 2020' do
      calculator = GetWeekAndYear.new
      result = calculator.call((Date.parse('1-1-2021')))
      expect(result[:week]).to eq(53)
      expect(result[:year]).to eq(2020)
    end
  end
  context 'get week for last day of year 2021' do
    it 'week is 52 year 2021' do
      calculator = GetWeekAndYear.new
      result = calculator.call((Date.parse('31-12-2021')))
      expect(result[:week]).to eq(52)
      expect(result[:year]).to eq(2021)
    end
  end
  context 'get week for March, 7th, 2021' do
    it 'week is 9 year 2021' do
      calculator = GetWeekAndYear.new
      result = calculator.call((Date.parse('7-3-2021')))
      expect(result[:week]).to eq(9)
      expect(result[:year]).to eq(2021)
    end
  end
end
