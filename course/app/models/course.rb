class Course < ApplicationRecord
  validates :title, :description, :instructor, :duration, :price, :level, :category, presence: true
  validates :video_url, format: { with: URI::regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  has_one_attached :image
  has_many :enrollments
  has_many :users, through: :enrollments
  
  # Callbacks
  before_save :process_learning_outcomes
  before_save :process_syllabus
  
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

  private

  def process_learning_outcomes
    if learning_outcomes.is_a?(String)
      self.learning_outcomes = learning_outcomes.split("\n").map(&:strip).reject(&:blank?)
    end
  end

  def process_syllabus
    if syllabus.is_a?(String) && syllabus.present?
      begin
        self.syllabus = JSON.parse(syllabus)
      rescue JSON::ParserError
        # Keep as is if invalid JSON
      end
    end
  end
end
