# frozen_string_literal: true

# This Model is a library containing various modules used in developing classes that need some features present on
# Active Record
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  # Associations
  has_one :subscription, dependent: :destroy
  has_one :payment_detail, dependent: :destroy

  has_many :documents, dependent: :destroy
  has_many :properties, dependent: :destroy

  # Activerecord callbacks
  before_save :normalize_phone
  after_create :transact_service
  after_create :update_confirmed_at
  after_create :send_change_password_email

  # Activerecord Validations
  validates :phone_number, phone: true, allow_blank: true

  def not_confirmed?
    confirmed_at.nil?
  end

  private

  def transact_service
    ActiveRecord::Base.transaction do
      create_subscription!
      create_payment_detail!
    end
  end

  def update_confirmed_at
    update!(confirmed_at: DateTime.now)
  end

  def send_change_password_email
    UserMailer.change_password(self, password).deliver_now! unless uid.nil?
  end

  def normalize_phone
    self.phone_number = Phonelib.parse(phone_number).full_e164
  end

end
