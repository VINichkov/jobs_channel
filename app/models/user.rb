class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #  :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:telegram]

  def self.from_omniauth(auth)
    logger.info '------------------------------from_omniauth'
    logger.info auth.to_h
    logger.info '------------------------------from_omniauth'
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.image = auth.info.image
      user.nickname = auth.info.nickname
      #user.email = auth.info.email
      user.password = auth.info.hash
    end
  end


end
