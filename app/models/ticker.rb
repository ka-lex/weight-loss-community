class Ticker

  attr_accessor :event, :username, :timestamp, :user

  def initialize event, user
    @event = event
    @username = user.username
    @user = user
  end

  def since
    since = ""
    since += "#{seconds} Sekunde(n) " if seconds < 60
    since += "#{minutes} Minute(n) " if minutes < 60
    since += "#{hours} Stunde(n) " if hours < 24
    
    since += "#{days} Tag(en) " if days > 0

    return since
  end

  def seconds
    ((Time.now - timestamp) ).to_i

  end

  def days
    (Date.today - timestamp.to_date)
  end

  def minutes
    (seconds / 60).to_i
  end

  def hours
    (minutes / 60).to_i
  end

  def self.private_changes user
    tickers = []

    max_age = 30.days

    # Mysql can only use one index, so we have to set the right index to use here manually (https://tomafro.net/2009/08/using-indexes-in-rails-choosing-additional-indexes)

    weights = user.weights.use_index('index_weights_on_created_at_and_user_id').where(:created_at => (Time.now.midnight - 30.days)..Time.now).order('created_at DESC').limit(10).all
    weights.each do |w|
        ticker = Ticker.new("hat eine neue Gewichtsangabe gemacht", user)
        ticker.timestamp = w.updated_at
        tickers << ticker      
    end

    targets = user.targets.where(:created_at => (Time.now.midnight - 30.days)..Time.now).order('created_at DESC').limit(10).all

    targets.each do |t|
      ticker = Ticker.new("hat ein Ziel eingetragen", user)
      ticker.timestamp = t.created_at
      tickers << ticker
    end

    messages = user.pinboard_messages.where(:created_at => (Time.now.midnight - 30.days)..Time.now).order('created_at DESC').limit(10).all
    messages.each do |t|
      unless t.from.nil?
        if t.from == t.to
          ticker = Ticker.new("sagt: #{t.body}", t.from)
        else
          ticker = Ticker.new("> #{t.to.username}: #{t.body}", t.from)
          #ticker = Ticker.new(" > #{t.to.username} hat eine Nachricht hinterlassen: #{t.body}", t.from)
        end

        ticker.timestamp = t.created_at
        tickers << ticker
      end
    end

    group_messages = user.group_members.where(:created_at => (Time.now.midnight - 30.days)..Time.now).order('created_at DESC').limit(10).all
    group_messages.each do |t|
      ticker = Ticker.new("ist Mitglid in Gruppe \"#{t.group.name}\" geworden" , user)
      ticker.timestamp = t.created_at
      tickers << ticker      
    end

    tickers.sort_by(&:timestamp).reverse    
  end

  def self.last_changes
    weights = Weight.order('created_at DESC').limit(10).all

    tickers = []

    weights.each do |w|
      unless w.user.nil?
        ticker = Ticker.new("hat eine neue Gewichtsangabe gemacht", w.user)
        ticker.timestamp = w.updated_at
        tickers << ticker
      end

    end

    targets = Target.order('created_at DESC').limit(10).all

    targets.each do |t|
      unless t.user.nil?
        ticker = Ticker.new("hat ein Ziel eingetragen", t.user)
        ticker.timestamp = t.created_at
        tickers << ticker
      end
    end

    users = User.order('created_at DESC').limit(10).all
    users.each do |u|
      ticker = Ticker.new("ist neues Mitglied", u)
      ticker.timestamp = u.created_at
      tickers << ticker

    end

    group_messages = GroupMember.order('created_at DESC').limit(10).all
    group_messages.each do |t|
       unless t.user.nil?
        ticker = Ticker.new("ist Mitglid in Gruppe \"#{t.group.name}\" geworden" , t.user)
        ticker.timestamp = t.created_at
        tickers << ticker
      end
    end

    tickers.sort_by(&:timestamp).reverse
  end
end