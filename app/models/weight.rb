class Weight < ActiveRecord::Base
  validates :value, :presence => true
  validate :date_uniqueness, :on => :create

  belongs_to :user

  scope :use_index, lambda {|index| 
    {:from => "#{quoted_table_name} USE INDEX(#{index})"} if Rails.env.production? # does not work with sqlite3, used for mysql
  }

  def date_uniqueness
    c_date = created_at || Date.today
    c_date = c_date.to_date
    errors.add(:created_at, "nur ein Wert pro Tag möglich") unless user.weights.where(:created_at => c_date.beginning_of_day..c_date.end_of_day).empty?        
  end

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

  
end
