# frozen_string_literal: true

# This Model is a library containing various modules used in developing classes that need some features present on
# Active Record
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_one :subscription, dependent: :destroy
  has_one :payment_detail, dependent: :destroy

  has_many :documents, dependent: :destroy
  has_many :properties, dependent: :destroy

  # Activerecord callbacks
  after_create :transact_service
  after_create :update_confirmed_at
  after_create :send_change_password_email

  private

  def transact_service
    ActiveRecord::Base.transaction do
      create_subscription!
      create_payment_detail!
    end
  end

  def update_confirmed_at
    update(confirmed_at: DateTime.now)
  end

  def send_change_password_email
    UserMailer.change_password(self, password).deliver_now! unless uid.nil?
  end

end
