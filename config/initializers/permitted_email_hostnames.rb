hostnames = ENV["PERMITTED_EMAIL_HOSTNAMES"]

if hostnames.present?
  GdsMissions.permitted_email_hostnames = hostnames.split(",")
else
  GdsMissions.permitted_email_hostnames = []
end
