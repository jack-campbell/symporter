class U < ActiveRecord::Base
  has_many :products, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token
  attr_accessor  :city, :institution
  before_save :downcase_email
  before_create :create_activation_digest
  
  validates :name,        presence: true, length: { maximum: 50 }
  validates :city,        presence: true, length: { maximum: 50 }  
  validates :institution, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,       presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  #doesn't i.d .. errors
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def feed
    products
  end
  
  def U.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def U.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = U.new_token
    update_attribute(:remember_digest, U.digest(remember_token))
  end
  
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def downcase_email
    self.email = email.downcase
  end
  
  def create_activation_digest
    self.activation_token  = U.new_token
    self.activation_digest = U.digest(activation_token)
  end
  
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UMailer.account_activation(self).deliver
  end
  
  def send_password_reset_email
    UMailer.password_reset(self).deliver
  end
  
  def create_reset_digest
    self.reset_token = U.new_token
    update_attribute(:reset_digest,  U.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  def self.search(query)
    where("name like ?", "%#{query}%") 
  end
end
