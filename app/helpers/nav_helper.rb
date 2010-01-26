module NavHelper
  
  def link_to_active(text, url, args = {}, condition = false)
    args[:class] = "#{args[:class]} active" if [request.url, request.path].include?(url_for(url)) || condition
    link_to(text, url, args)
  end
  
  def link_to_controller(text, controller, args = {})
    link_to_active(text, controller, args, cname == controller.to_s)
  end
  
end