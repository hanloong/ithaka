module ApplicationHelper
  def display_base_errors(resource)
    return '' if (resource.errors.empty?) || (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
    #{messages}
    </div>
    HTML
    html.html_safe
  end

  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                      tables: true,
                                      autolink: true,
                                      no_intra_emphasis: true,
                                      fenced_code_blocks: true,
                                      superscript: true,
                                      underline: true,
                                      highlight: true,
                                      quote: true
                                      )
    markdown.render(text).html_safe
  end

  def avatar_url(user, size = 48)
    if user.avatar_url.present?
      user.avatar_url
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=wavatar"
    end
  end

  def beta_label
    html = <<-HTML
    <span class="label label-pink">beta</span>
    HTML
    html.html_safe
  end

  def logo
    html = <<-HTML
    <span class='logo'>
      <span class='six'>ithaka</spam>
    </span>
    HTML
    html.html_safe
  end

  def dark_logo
    html = <<-HTML
    <span class='dark-logo'>
      <span class='six'>ithaka</spam>
    </span>
    HTML
    html.html_safe
  end

  def influence_text(score)
    if score < 3
      'poor'
    elsif score > 8
      'excellent'
    elsif score > 6
      'good'
    else
      'average'
    end
  end
end
