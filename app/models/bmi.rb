class Bmi

  def self.rating sex, bmi
    if sex == "m"
      case bmi
      when 0..20 then return "Untergewicht"
      when 20..25 then  return "Normalgewicht"
      when 25..30 then return  "Übergewicht"
      when 30..40 then return  "Adipositas"
      when 40..1000 then return  "massive Adipositas"
      end
    end
    if sex == "w"
       case bmi
      when 0..19 then return  "Untergewicht"
      when 19..24 then return  "Normalgewicht"
      when 24..30 then return  "Übergewicht"
      when 30..40 then return  "Adipositas"
      when 40..1000 then return  "massive Adipositas"
      end
    end
  end
end