class Link < ActiveRecord::Base
  belongs_to :mission

  validates :url, presence: true
end
