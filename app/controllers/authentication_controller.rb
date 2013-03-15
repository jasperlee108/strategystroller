class AuthenticationController < ApplicationController

  ## Error Code
  SUCCESS = 1
  ERR_BAD_CREDENTIALS = -1
  ERR_USER_EXISTS = -2
  ERR_BAD_USERNAME = -3
  ERR_BAD_PASSWORD = -4
  
  ## Position Code
  CU = 0
  PROVIDER = 1

  def login_result
    #validate login name + password: User model
    #either display error message: controller
    #or direct to CU panel/Provider panel/Admin panel (prob change admin stuff later)
    username = params[:username]
    password = params[:password]
    company_id = params[:company][:name].to_i
    result = User.validate_login(username, password, company_id)
    if (result > 0)
      position = User.get_position(username, password, company_id)
      return {:errCode => result, :company => company_id , :position => position}
    else
      return {:errCode => result}
    end
  end


  def login
    if (request.post?)
      result = login_result
      code = result[:errCode]
      if (code > 0) #success
        #admin, cu, provider
        position = result[:position]
        if (position == CU)
          redirect_to controller_panel_path
        elsif (position == PROVIDER)
          redirect_to provider_panel_path
        else
          flash[:error] = "Unidentifiable position in handle_login"
          #should not happen
        end
      else #display login page with error message
       #@errormsg = "Username/Password is incorrect. Please try again."
        flash[:error] = "Username/Password is incorrect. Please try again."

        redirect_to login_path
      end
    end
  end

  def create_user
  end

  def creation_token
  end

  def logout
  end
end
