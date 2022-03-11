# frozen_string_literal: true

# This Model is a library containing various modules used in developing classes that need some features present on
# Active Record
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :documents, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_one :subscription, dependent: :destroy

  # Activerecord callbacks
  after_create :set_subscription
  after_create :send_change_password_email

  def set_subscription
    create_subscription
  end

  def send_change_password_email
    UserMailer.change_password(self, password).deliver_now! unless uid.nil?
  end
end
