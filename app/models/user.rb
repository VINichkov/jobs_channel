class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #  :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:telegram]

  def self.from_omniauth(auth)
    where(provider: :telegram, uid: auth.id).first_or_create do |user|
      user.provider = :telegram
      user.uid = auth.id
      user.first_name auth.first_name
      user.last_name auth.last_name
      #user.email = auth.info.email
      user.password = auth.hash
    end
  end


end
