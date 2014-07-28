class Mission < ActiveRecord::Base
  include AASM
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :team
  has_many :links

  validates :name, presence: true

  accepts_nested_attributes_for :links, allow_destroy: true, reject_if: :all_blank

  scope :in_completion_order, -> { order('completed_on asc') }

  mount_uploader :mission_patch, MissionPatchUploader

  aasm column: 'state' do
    state :in_progress, initial: true
    state :completed

    event :complete do
      transitions from: :in_progress, to: :completed
    end
  end
end
