class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

 after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= 'active'
  end
end
