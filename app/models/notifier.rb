class Notifier < ActionMailer::Base
  
  def signup_notification(recipient)
    recipients    recipient.email_address
    from          "notification@threadfree.net"
    subject       "Welcome to threadfree!"
    body          :account_name => recipient.name
    reply_to      "comments@threadfree.net"
    content_type  "text/html"
  end
  
  def reset_password(recipient, new_password)
    recipients    recipient.email_address
    from          "notification@threadfree.net"
    subject       "Resetting your Password"
    body          :new_password => new_password
    reply_to      "comments@threadfree.net"
    content_type  "text/html"
  end


end
