class Subscription < ActiveRecord::Base
  belongs_to :account

  def self.calculate_renewal length, period
    
    enddate = nil

    if (length.class == Fixnum) && (["day", "week", "month", "year"].include? period)
    

      today = Date.today

      enddate = case period
        when "day" then today + length.days
        when "week" then today + length.weeks
        when "month" then today + length.months
        when "year" then today + length.years
      end

      puts enddate
    end

    

    enddate
  end

end
