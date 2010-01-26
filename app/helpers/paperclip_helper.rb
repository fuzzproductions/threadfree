module PaperclipHelper
  
  def link_to_attachment(attachment, options = {})
    return 'No file.' unless attachment.file?
    style = options[:style].to_s || :original
    use_image = options[:use_image] || true
    text = IMAGE_TYPES.include?(attachment.content_type) && use_image ? image_tag(attachment.url(style)) : "Link to #{attachment.original_filename}"
    return link_to(text, attachment.url)
  end
  alias_method :link_to_paperclip, :link_to_attachment
  
end