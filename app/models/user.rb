require 'exponent-server-sdk'

class User < ActiveRecord::Base
  has_many :universidades
  has_one :token, :dependent => :destroy

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  before_validation :set_uid_as_email
  after_create :send_welcome_email

  validates :provider, :uid, :email, presence: true

  def as_json(*)
    UserSerializer.new(self, {root: false})
  end

  def set_uid_as_email
    self.uid = email if uid.blank?
  end

  def self.send_push_notification
    exponent.publish(
      exponentPushToken: 'ExponentPushToken[WgeYRaGKTOn5j3H8tPZMMh]',
      message: 'Send Push Notification Test',
      data: { foo: 'bar' },
    )
  end

  def send_welcome_email
    UserRegistrationMailer.welcome_email(self.id).deliver_later
  end
end
