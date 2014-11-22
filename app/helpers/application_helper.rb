module ApplicationHelper
  def cus_time(time)
    time.strftime("%Y-%m-%d %H:%M:%S")
  end

  def render_page_title
    site_name = ENV['title']
    title = @page_title ? "#{@page_title} &raquo; #{site_name}" : site_name rescue "SITE_NAME"
    content_tag("title", title, nil, false)
  end

  def lazy_image_tag(url)
    image_tag('', :"data-original" => url, class:"img-responsive lazy")
  end
end
