class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :bookmarks
  has_many :reviews
  mount_uploader :image, BookImageUploader
  
  validates :title,        presence: true
  validates :user_id,      presence: true
  validates :author,       presence: true
  validates :publisher,    presence: true
  validates :price,        presence: true, numericality: true
  validates :publish_date, presence: true
  validates :category_id,  presence: true
  
  scope :category_filter, -> category_id do
    where(category_id: category_id) if category_id.present?
  end
  
end
