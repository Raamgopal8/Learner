class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :enrollments
  has_many :courses, through: :enrollments

  validates :username, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :firebase_uid, uniqueness: { scope: :provider }, allow_blank: true
  validates :provider, inclusion: { in: %w[email password google facebook] }, allow_blank: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_firebase_uid(uid, provider = 'email')
    find_or_create_by(firebase_uid: uid, provider: provider) do |user|
      # User will be populated with Firebase data in the controller
    end
  end

  def firebase_user?
    firebase_uid.present?
  end

  def update_streak!
    today = Date.current
    return if last_streak_date == today

    if last_streak_date == today.yesterday
      increment!(:streak_count)
    else
      update!(streak_count: 1)
    end
    
    update!(last_streak_date: today)
  end
end