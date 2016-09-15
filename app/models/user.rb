class User < ActiveRecord::Base
	attr_accessor :remember_token
    before_save { self.email = email.downcase } #chuyen email ve kieu thuong khi luu vao csdl
    validates :name,  presence: true, length: { maximum: 50 }
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  	validates :email, presence: true, length: { maximum: 255 },
  		                format: { with: VALID_EMAIL_REGEX } ,
  		                uniqueness: { case_sensitive: false } # ham xac nhan email
  		 has_secure_password
  		 validates :password, presence: true, length: { minimum: 6 }, allow_nil: true #co the tao ra mk bang 8 dau cach
  		 # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  # Returns a random token.tra 1 ma thong bao ngau nhien
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  # Nho nguoi dung trong CSDL de th lan sau
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #Trả về true nếu token cho phù hợp
  def authenticated?(remember_token)
   return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  # quen di nguoi su dung
  def forget
    update_attribute(:remember_digest, nil)
  end

end