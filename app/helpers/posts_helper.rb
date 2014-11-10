module PostsHelper
  def truncate_html(html, length)
    truncate(strip_tags(html), length: length)
  end
end
