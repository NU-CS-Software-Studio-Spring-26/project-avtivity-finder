class Activity < ApplicationRecord
  belongs_to :user

  has_many :activity_signups, dependent: :destroy
  has_many :attendees, through: :activity_signups, source: :user

  validates :title, presence: true
  validates :city, presence: true
  validates :category, presence: true
  validates :event_date, presence: true
  validates :capacity,
            numericality: { only_integer: true, greater_than: 0 },
            allow_nil: true

  has_many_attached :images
  validate :image_limit

  def ordered_images
    images.attachments.order(:position, :created_at)
  end

  def thumbnail
    ordered_images.first
  end

  def attendee_count
    activity_signups.count
  end

  def at_capacity?
    capacity.present? && attendee_count >= capacity
  end

  private
  def image_limit
    if images.attachments.length > 10
      errors.add(:images, "maximum is 10 images")
    end
  end
end
