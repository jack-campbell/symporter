module UsHelper
  def gravatar_for(u)
    gravatar_id = Digest::MD5::hexdigest(u.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: u.name, class: "gravatar")
  end
end
