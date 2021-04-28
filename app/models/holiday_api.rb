
class HolidayAPI

  def self.get_holidays(country = "US", year = Time.now.year)
    holiday_1 = Faraday.get "https://date.nager.at/api/v2/PublicHolidays/#{year}/#{country}"
    holiday_2 = Faraday.get "https://date.nager.at/api/v2/PublicHolidays/#{year+1}/#{country}"
    thing_1 = JSON.parse(holiday_1.body.gsub('=>', ':'))
    thing_2 = JSON.parse(holiday_2.body.gsub('=>', ':'))
    holidays = thing_1 + thing_2
  end

  def self.upcoming(number = 3)
    holidays = get_holidays
    today = Time.now.to_date

    upcomeing_holidays = holidays.select do |holiday|
      holiday_date = DateTime.parse(holiday["date"])
      today < holiday_date
    end

    coming_soon = []
    number.times{|index| coming_soon << holidays[index]}

    presentable = coming_soon.map {|info| name_and_date(info)}

    return presentable
  end

  def self.name_and_date(data_hash)
    "#{data_hash["name"]}: #{data_hash["date"]}"
  end

end
