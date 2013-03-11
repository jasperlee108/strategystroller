/*Make sure HTML loads before javascript*/
$(function() { 

  /*Load login page*/


  SUCCESS = 1;
  ERR_BAD_CREDENTIALS = -1;
  ERR_USER_EXISTS = -2;
  ERR_BAD_USERNAME = -3;
  ERR_BAD_PASSWORD = -4;




  /*Choose which error msg to display*/
  function error_type(errCode) {
    if (errCode==ERR_BAD_CREDENTIALS) {
      return ("Invalid username and password combination. Please try again.");
    } else if (errCode == ERR_BAD_USERNAME) {
      return ("The user name should be non-empty and at most 128 characters long. Please try again.");
    } else if (errCode == ERR_BAD_PASSWORD) {
      return ("The password should be at most 128 characters long. Please try again.");
    } else if (errCode == ERR_USER_EXISTS) {
      return ("This user name already exists. Please try again.");
    } else {
      return ("Unknown error occurred. Please try again.");     
    }
  }

  /*transmit data from browser to server*/
  function handle_clicks(urlstring) {
    console.log(urlstring);
    username = $('#username').val();
    password = $('#password').val();
    $.ajax({dataType:'json',
            contentType:'application/json',
            url:urlstring,
            data:JSON.stringify({username:username, password:password}),
            type:"POST",
            success:function(data){return handle_login(data,username);},
            failure:function(data) {alert('failure to log in');}} );
    return false;
  }

  /*Clicking buttons*/
  $('#loginbutton').click(function(){
   return handle_clicks('/authentication/login');
  });

  /*$('#addbutton').click(function(){
    return handle_clicks('/users/add');
  });

  $('#logoutbutton').click(function(){
    show_login();
    return false;
  });
*/
});