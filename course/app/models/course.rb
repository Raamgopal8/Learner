class Course < ApplicationRecord
  validates :title, :description, :instructor, :duration, :price, :level, :category, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  has_one_attached :image
  has_many :enrollments
  has_many :users, through: :enrollments
  # Scopes for filtering
  scope :by_category, ->(category) { where(category: category) }
  scope :by_level, ->(level) { where(level: level) }
  scope :featured, -> { where(featured: true) }
  scope :recent, -> { order(created_at: :desc) }

  # Instance methods
  def formatted_price
    "₹#{price.to_i}"
  end

  def self.categories
    [
      'Web Development',
      'Data Science',
      'Machine Learning',
      'UI/UX Design',
      'Mobile Development',
      'Digital Marketing',
      'Languages',
      'Business'
    ]
  end

  def self.levels
    ['Beginner', 'Intermediate', 'Advanced']
  end
end
