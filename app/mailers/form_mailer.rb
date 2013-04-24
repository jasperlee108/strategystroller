class FormMailer < ActionMailer::Base
  default from: "strategystroller@gmail.com"

  def form_email(user,form_url)
  	@form_url = form_url
  	@user = user
  	mail(:to => user.email, :subject=> "Form from the StrategyStroller Team")
  end
end
