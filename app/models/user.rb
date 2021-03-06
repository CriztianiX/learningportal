class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  cattr_accessor  :current

  after_create :create_preferences!
  # serialize :preferences

  default_scope { order "last_sign_in_at DESC" }

  self.per_page = 10

  # {
  #   "user_id": 1234,     # ID of user from users table
  #   "types": {
  #     "video": 100,       # Type of content: View Count (High Priority)
  #     "image": 50,
  #     "text": 25
  #   },
  #   "total": 1000,        # DateTime.parse(date).to_i (for potential sorting purposes)
  #   "last_login_at": 1337108502
  # }

  def self.seed!
    password = "CouchbaseUser"
    1000.times do
      email = Faker::Internet.email
      User.create(:email => email, :password => password)
      puts "----> Creating user #{email}"
    end
  end

  def self.random
    offset = rand(User.count)
    User.first(:offset => offset)
  end

  def increment!(type)
    if self.preferences
      if type
        type = type.to_s
        count = self.preferences['types'][type]
        self.preferences['types'][type] = count + 1
      end
      total = self.preferences['total']
      self.preferences['total'] = total + 1
      update_preferences!
    end
  end

  def preference(type=nil)
    return 0 unless self.preferences
    return self.preferences['total'] || 0 if type == "total"
    self.preferences['types'][type] || 0
  end

  def default_preferences
    {
      "user_id" => self.id,
      "types" => {
        "video" => 0,
        "image" => 0,
        "text"  => 0
      },
      "total" => 0,
      "last_sign_in_at" => self.last_sign_in_at
    }
  end

  def update_preferences!
    Couch.client(:bucket => "profiles").set(id.to_s, @preferences)
  end

  def create_preferences!
    @preferences = default_preferences
    update_preferences!
  end


  def preferences
    begin
      return @preferences ||= Couch.client(:bucket => "profiles").get(id.to_s)
    rescue Couchbase::Error::NotFound
      return create_preferences!
    end
  end

end
