class GetWeekAndYear

  def call(date = Time.zone.now)
    date_parsed = date.strftime('%V-%G').split('-')
    {
      week: date_parsed.first.to_i,
      year: date_parsed.second.to_i
    }
  end

end

