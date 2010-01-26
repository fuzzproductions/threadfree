# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def strip_and_format(text)
    return simple_format(strip_tags(text))
  end
  
  def cname
    controller.controller_name
  end
  
  def aname
    controller.action_name
  end
  
  def link_to_external(text, url, options = {})
    link_to text, 'http://' + url.gsub(/^\w+:/,''), options.merge(:popup => true)
  end
  
  def external_url(url, options = {})
    protocol = options[:protocol].try(:to_s).blank? || 'http'
    "#{protocol}://" + url.gsub(/^\w+:/,'')
  end
    
  
  # Format  Meaning
  # %a  The abbreviated weekday name (“Sun’’)
  # %A  The full weekday name (“Sunday’’)
  # %b  The abbreviated month name (“Jan’’)
  # %B  The full month name (“January’’)
  # %c  The preferred local date and time representation
  # %d  Day of the month (01..31)
  # %H  Hour of the day, 24-hour clock (00..23)
  # %I  Hour of the day, 12-hour clock (01..12)
  # %j  Day of the year (001..366)
  # %m  Month of the year (01..12)
  # %M  Minute of the hour (00..59)
  # %p  Meridian indicator (“AM’’ or “PM’’)
  # %S  Second of the minute (00..60)
  # %U  Week number of the current year, starting with the first Sunday as the first day of the first week (00..53)
  # %W  Week number of the current year, starting with the first Monday as the first day of the first week (00..53)
  # %w  Day of the week (Sunday is 0, 0..6)
  # %x  Preferred representation for the date alone, no time
  # %X  Preferred representation for the time alone, no date
  # %y  Year without a century (00..99)
  # %Y  Year with century
  # %Z  Time zone name
  # %%  Literal “%’’ character
  def format_datetime(datetime, my_format=nil)
    return if datetime.blank?
    m_no_0 = datetime.strftime("%m").gsub(/^0/,"")
    d_no_0 = datetime.strftime("%d").gsub(/^0/,"")
    
    case my_format
    when nil
      # => example: 09.10.2009 - 05:25pm
      datetime.strftime("%m.%d.%Y - %I:%M%p").gsub("PM","pm").gsub("AM","am") unless datetime.blank?
    when :sortable_date
      content_tag 'span', format_datetime(datetime, :date), :rel => format_datetime(datetime, :sortable)
    when :sortable
      datetime.strftime("%Y/%m/%d")
    when :date
      datetime.strftime("#{m_no_0}/#{d_no_0}/%Y") unless datetime.blank?
    when :xml
      # => example: 8/7/2009 10:41:57 AM
      datetime.strftime("#{m_no_0}/#{d_no_0}/%Y %I:%M:%S %p") unless datetime.blank?
    else
      raise "You did not select a valid format."
    end
  end
    
end
