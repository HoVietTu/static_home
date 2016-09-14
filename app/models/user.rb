class User < ActiveRecord::Base
    before_save { self.email = email.downcase } #chuyen email ve kieu thuong khi luu vao csdl
    validates :name,  presence: true, length: { maximum: 50 }
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  	validates :email, presence: true, length: { maximum: 255 },
  		                format: { with: VALID_EMAIL_REGEX } ,
  		                uniqueness: { case_sensitive: false } # ham xac nhan email
  		 has_secure_password
  		 validates :password, presence: true, length: { minimum: 6 } #co the tao ra mk bang 8 dau cach

end