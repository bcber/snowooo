module ApplicationHelper
  def cus_time(time)
    time.strftime("%Y-%m-%d %H:%M:%S")
  end

  def paginate(records, options={})
    will_paginate records, renderer: BootstrapPagination::Rails, inner_window: 1, outer_window: 1
  end

  def render_page_title
    site_name = ENV['title']
    title = @page_title.present? ? " #{@page_title} | #{site_name} ": site_name rescue "SITE_NAME"
    content_tag("title",title)
  end

  def lazy_image_tag(url)
    image_tag('http://assets2.useetv.com/img/load_img.gif', :"data-original" => url, class:"img-responsive lazy")
  end

  def query_params
    params.except(:action, :controller,:page)
  end

  def query_params_except(key,value)
    default = query_params.dup
    default[key].delete(value)
    default.delete(key) if default[key].blank?
    default
  end

  MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
      'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
      'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
      'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
      'webos|amoi|novarra|cdm|alcatel|pocket|iphone|mobileexplorer|mobile'

  def mobile?
    agent_str = request.user_agent.to_s.downcase
    return false if agent_str =~ /ipad/
    agent_str =~ Regexp.new(MOBILE_USER_AGENTS)
  end

  def add_query(k,v)
    default = params.dup
    default[k] ||= []
    default[k].push(v)
    default[k].uniq!
    default
  end

  def get_rgb(color)
    case color
      when "black"
        "#000"
      when "blue"
        "#369"
      when "brown"
        "#963"
      when "gray"
        "#ccc"
      when "green"
        "#093"
      when "orange"
        "#f93"
      when "purple"
        "#639"
      when "red"
        "red"
      when  "white"
        "#fff"
      when "yellow"
        "#ff0"
      else
        "#000"
    end
  end

  def color_list
    %w{black blue brown gray green orange purple red white yellow}
  end
end
