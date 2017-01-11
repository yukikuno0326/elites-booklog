class Book < ActiveRecord::Base
  belongs_to :user
  mount_uploader :image, BookImageUploader
  
  validates :title,        presence: true
  validates :user_id,      presence: true
  validates :author,       presence: true
  validates :publisher,    presence: true
  validates :price,        presence: true, numericality: true
  validates :publish_date, presence: true
end
