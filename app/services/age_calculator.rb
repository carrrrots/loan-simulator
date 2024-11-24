class AgeCalculator
  def initialize(birthdate)
    @birthdate = birthdate
    @now = Time.now
  end

  def calculate
    validate_date
    age_in_years - (birthday_not_yet_reached_this_year? ? 1 : 0)
  end

  private

  def age_in_years
    @now.year - @birthdate.year
  end

  def birthday_not_yet_reached_this_year?
    @now.month < @birthdate.month || (@now.month == @birthdate.month && @now.day < @birthdate.day)
  end

  def validate_date
    raise ArgumentError, "Invalid date" unless @birthdate.is_a?(Date)
  end
end
