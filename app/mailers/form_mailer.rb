class FormMailer < ActionMailer::Base
  default from: "strategystroller@gmail.com"

  GOAL = 1
  INDICATOR = 2
  PROJECT = 3
  ACTIVITY = 4

  def decode_id(id)
      decoded = Base64.decode64(id.to_s)
      return decoded
    end

    def extract_form_id(url)
      form_id = url.split("form_id=")[1]
      return form_id
    end

    def extract_entry_id(url)
      entry_id = url.split("entry_id=")[1]
      return entry_id
    end

  def decode_url(url) #only for provider define so far 
      form_id = decode_id(extract_form_id(url))
      entry_id = decode_id(extract_entry_id(url))
      form = Form.find_by_id(form_id)
      lookup = form.lookup
      if (lookup == GOAL) 
        category = "goal"
      elsif (lookup == INDICATOR)
        category = "indicator"
      elsif (lookup == PROJECT)
        category = "project"
      elsif (lookup ==  ACTIVITY)
        category = "activity"
      end
      return url = "http://localhost:3000/provider/" + category + "_define?entry_id=" + entry_id + "&form_id=" + form_id #temp
    end

  def form_email(user,form_url)
  	@form_url = decode_url(form_url) #useless right now, need to figure out how to decode without revealing url
  	@user = user
  	mail(:to => user.email, :subject=> "Form from the StrategyStroller Team")
  end
end
