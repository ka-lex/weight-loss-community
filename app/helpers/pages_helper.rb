module PagesHelper

  def weights_chart_series(user, start_time)
    weights_by_day = user.weights.where(:created_at => start_time.beginning_of_day..Time.zone.now.end_of_day).
      group("date(created_at)").
      select("created_at, sum(value) as total_value, id")

    end_date = Date.today

    values = []



    (start_time.to_date..end_date).map do |date|

      weight = weights_by_day.detect { |weight| weight.created_at.to_date == date }

      unless weight.nil?               
        value = weight.total_value.to_f / 10
        values << [date, value, weight.id] unless value == 0 #.to_time.to_i*1000
      end
    end

    values

  end

  
  def user_weights_chart_series(start_time, user)

    start_weight = user.current_weight



    unless user.target.nil?
      end_date = user.target.end_date
      end_weight = user.target_weight
    else
      end_date = Date.today
      end_weight = 0.0
    end


    (0..user.days_to_target).map do |counter|
      weight = start_weight - counter * (start_weight - end_weight) / (user.days_to_target )
    end.inspect

  end

  def calculated_weights(start_time)

  end


end
