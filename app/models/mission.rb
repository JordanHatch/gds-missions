class Mission < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :team

  mount_uploader :mission_patch, MissionPatchUploader
end
