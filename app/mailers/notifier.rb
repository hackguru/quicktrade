class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def notify_gap(recipient)
    @account = recipient
    mail(:to => recipient.email)
    puts "HEREREEEEEEEEEE: "+recipient.email
  end

end
