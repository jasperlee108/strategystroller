RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

=begin

Note: to overcome the need to confirm due to :confirmable module, simply use skip_confirmation! before saving the user:

def create
  @user = User.new(params[:user])
  @user.skip_confirmation!
  @user.save!
end

----------

From http://devise.plataformatec.com.br/

Now you are ready to use the sign_in and sign_out methods. Such methods have the same signature as in controllers:

sign_in :user, @user   # sign_in(scope, resource)
sign_in @user          # sign_in(resource)

sign_out :user         # sign_out(scope)
sign_out @user         # sign_out(resource)

There are two things that is important to keep in mind:

1) These helpers are not going to work for integration tests driven by Capybara or Webrat.
They are meant to be used with functional tests only.
Instead, fill in the form or explicitly set the user in session;

2) If you are testing Devise internal controllers or a controller that inherits from Devise's,
you need to tell Devise which mapping should be used before a request.
This is necessary because Devise gets this information from router,
but since functional tests do not pass through the router, it needs to be told explicitly.
For example, if you are testing the user scope, simply do:

@request.env["devise.mapping"] = Devise.mappings[:user]
get :new

=end
