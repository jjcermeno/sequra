class CalculateFee

  def call(amount = 0.0)
    fee = case
      when (amount < 50)
        amount * (1 / 100.0)
      when (amount >= 50 && amount < 300)
        amount * (0.95 / 100.0)
      else
        amount * (0.85 / 100.0)
      end
    return fee
  end

end

