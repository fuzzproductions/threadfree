class LoginController < ApplicationController
  
  def create_user
    session[:user_id] = nil
    @user = User.new(params[:user])
    if request.post? and verify_recaptcha(:model => @user, :message => "It appears you've entered the recaptcha code wrong. Please do try again.", :private_key => "6Lc5zAoAAAAAANG3q9wbYeznpWgex0IMqGHejtdd")
      if @user.save
        session[:user_id] = User.last.id
        Notifier.deliver_signup_notification(User.last)
        flash[:notice] = "Welcome to threadfree! This is your profile page, which you can customize. You can upload designs from the link designs from the 'Upload Your Own' link in the top bar, and you can return here by clicking 'Manage Designs.' Have fun!"
        redirect_to User.last
      end
    end
  end

  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:user][:name], params[:user][:password])
      if user
        session[:user_id] = user.id
        if params[:remember_me] 
          userId = (user.id).to_s  
          cookies[:remember_me_id] = { :value => userId, :expires => 30.days.from_now }
        end
      else
        flash[:login_message] = "Sorry, that's not the right password and username."
      end
      if session[:original_uri].nil? or session[:original_uri] == "/login/create_user"
        redirect_to root_url
      else
        redirect_to session[:original_uri]
      end
    end
  end

  def logout
    session[:user_id] = nil
    if cookies[:remember_me_id] then cookies.delete :remember_me_id end
    redirect_to root_url
  end
  
  def update_profile
    @update_user = @current_user
    puts params[:update_user]
    if request.post? and @update_user.update_attributes(params[:update_user])
       redirect_to profile_url(:id => @current_user)
    end
  end

  def change_password
    @update_user = @current_user
    if request.post? and @update_user.update_attributes(params[:change_password])
      redirect_to profile_url(:id => @current_user)
    end   
  end

  def change_profile_picture
    @update_user = @current_user
    if request.post? and @update_user.update_attributes(params[:change_profile_picture])
      redirect_to profile_url(:id => @current_user)
    end   
  end

  def forgot_password
    
  end

  def reset_password
    puts "RESET ACTION CALLED"
    @address = params[:account_data][:email_address].to_s
    puts @address
    if @address != "" and @address != nil
      puts "THERES AN EMAIL ADDRESS"
      @wanted_user = User.search(:email_address_like => @address)
    end
    @user_name = params[:account_data][:name].to_s
    if params[:account_data][:name] != "" and params[:account_data][:name] != nil
      puts "THERES A USER NAME" 
      puts @user_name
      @wanted_user = User.search(:name_is => @user_name).first
    end
    if @wanted_user != nil
      puts "@WANTED_USER"
      puts @wanted_user.name
      @new_password = User.reset_password(@wanted_user.id)
      Notifier.deliver_reset_password(@wanted_user, @new_password)
      flash[:notice] = "Check your email, we've reset your password"
      redirect_to root_url
    else
      flash[:error] = "Sorry, we couldn't find a user with those credentials."
      redirect_to forgot_password_url
    end
  end

  def index
    redirect_to root_url
  end

  def delete_user
  end

end
