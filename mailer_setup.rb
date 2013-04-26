require 'mail'

print "Setting up mailer configs for Strategy Stroller \n"

options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :domain               => 'localhost',
            :user_name            => 'strategystroller@gmail.com',
            :password             => 'cs169squad',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

Mail.defaults do
  delivery_method :smtp, options
end
