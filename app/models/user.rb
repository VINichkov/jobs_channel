class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:telegram]

  def self.(auth)
    where(provider: auth.provider, uid: auth.id).first_or_create do |user|
      user.provider = auth.provider || :telegram
      user.uid = auth.id
      #user.email = auth.info.email
      user.password = auth.hash
    end
  end


end
