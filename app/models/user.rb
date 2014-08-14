class User < ActiveRecord::Base
  validates :provider_uid, :presence => true, :uniqueness => true
  validate :email_has_permitted_hostname, on: :create

  class CreationFailure < StandardError; end

  def self.find_or_create_from_auth_hash!(auth_hash)
    existing_user = where(email: auth_hash[:info][:email]).first

    if existing_user.present?
      existing_user.update_attributes(atts_from_auth_hash(auth_hash))
      existing_user
    else
      user = new(initial_atts_from_auth_hash(auth_hash))

      if user.save
        return user
      else
        raise CreationFailure, user.errors.full_messages.join(", ")
      end
    end
  end

private
  def self.atts_from_auth_hash(hash)
    {
      name: hash[:info][:name],
      image_url: hash[:info][:image],
      provider: hash[:provider],
      provider_uid: hash[:uid],
    }
  end

  def self.initial_atts_from_auth_hash(hash)
    atts_from_auth_hash(hash).merge(
      email: hash[:info][:email]
    )
  end

  def email_has_permitted_hostname
    if email.blank? || GdsMissions.permitted_email_hostnames.empty?
      return
    end

    hostname = email.match(/@([A-Za-z0-9\-\.]+)\Z/) {|matches|
      matches[1]
    }

    unless GdsMissions.permitted_email_hostnames.include?(hostname)
      errors.add(:email, "must be a GDS email")
    end
  end
end
