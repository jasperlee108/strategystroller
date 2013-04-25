ActiveAdmin.register User do
  index do                            
    column :username
    column :email                     
    column :business_code
    column :controlling_unit
    column :confirmation_token          
    default_actions                   
  end                                 

  filter :username
  filter :email
  filter :business_code             
  filter :controlling_unit

  form do |f|                         
    f.inputs "User Details" do       
      f.input :username
      f.input :email                  
      f.input :business_code
      f.input :controlling_unit
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end    
end
