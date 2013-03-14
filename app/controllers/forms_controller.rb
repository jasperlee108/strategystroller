class FormsController < ApplicationController
  before_filter :authenticate_user!
end
