class ProviderController < ApplicationController
  before_filter :authenticate_user!
end
