class Mission < ActiveRecord::Base
  include AASM
  extend FriendlyId

  friendly_id :name, use: :slugged

  belongs_to :team
  has_many :links

  mount_uploader :mission_patch, MissionPatchUploader

  aasm column: 'state' do
    state :in_progress, initial: true
    state :completed

    event :complete do
      transitions from: :in_progress, to: :completed
    end
  end
end
