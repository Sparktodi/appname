# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Appname'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

  def gravatar_for(user, size: 30, css_class: '')
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.jpg?s=#{size}"
    image_tag(gravatar_url, alt: user.email, class: "rounded#{css_class}")
  end
end
