class Target < ActiveRecord::Base
  validates :value, :presence => true
  validates :title, :presence => true
  validates_numericality_of :value, :greater_than => 0, :message => 'Wert größer 0'
  validates_numericality_of :value, :less_than => 2000, :message => 'Wert zu groß'
  validates :end_date, :presence => true
  validate :end_date_value
  
  belongs_to :user
  
  def value_string
    self.value.to_f / 10    
  end

  def value_string= value_string

    if value_string.include?(',')
        en_string = value_string.gsub(",", ".")
    else
      en_string = value_string
    end

    self.value = (en_string.to_d * 10).to_i

  end

  def end_date_value
    if end_date
      begin
        date = end_date.to_date

        if (date > Date.today + 3.months)
          errors.add('Zieldatum',' sollte innerhalb der nächsten 3 Monate erreichbar sein')

        end

      rescue ArgumentError
        false
      end
      end
  end

end
