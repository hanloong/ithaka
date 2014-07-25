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
    if user.photo_url
      user.photo_url
    elsif user.avatar_url.present?
      user.avatar_url
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "https://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=wavatar"
    end
  end

  def anonymous_avatar_url
    "https://gravatar.com/avatar/gravatar_id.png?s=40&d=mm"
  end

  def beta_label
    html = <<-HTML
    <span class="label label-primary">beta</span>
    HTML
    html.html_safe
  end

  def markdown_cheatsheet
    <<-eos
# Heading One
## Heading Two
### Heading Three

Text can be styled with

- in lists with
- **bold**,
- *italics*,
- _underlines_ and
- ==highlights==

1. and those lists
2. can be numbered

> And finally a quote

[Markdown further reading](http://daringfireball.net/projects/markdown/syntax)
    eos
  end
end
