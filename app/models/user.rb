class User < ActiveRecord::Base
  has_many :plays#, :dependent => destroy
  has_many :games, :through => :plays

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation

  validates :name, presence: true


  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)
    if user and user.confirmed?
      user.provider = auth.provider
      user.uid = auth.uid
      return user
    end

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      email_is_verified = auth.info.email && (auth[:extra][:raw_info][:email_verified] || auth.info.verified)

      logger.debug "email verified: #{email_is_verified}"
      logger.debug "auth.info.email: #{auth.info.email}"
      logger.debug "auth[:extra][:raw_info][:email_verified]: #{auth[:extra][:raw_info][:email_verified]}"
      logger.debug "auth.info.verified: #{auth.info.verified}"
      logger.debug "auth: #{auth}"

      if email_is_verified
        user.skip_confirmation!
      end
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      #user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: :true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end


  def update_with_password (params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end

