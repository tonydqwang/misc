module SessionsHelper

  def sign_in(user)

    cookies.permanent[:remember_token] = user.remember_token

    self.current_user = user
  end
  
  def current_department
    #@current_department ||= Department.find_by_user_id((User.find_by_remember_token(cookies[:remember_token])).id)
	@current_department ||= Department.find_by_id((Employee.find_by_user_id((User.find_by_remember_token(cookies[:remember_token])).id)).department_id)
  end
  
  def current_employee
	@current_employee ||= Employee.find_by_user_id((User.find_by_remember_token(cookies[:remember_token])).id)
  end
  
  def current_employee (user)
	@current_employee = Employee.find_by_user_id(user.id)
  end
  
  def getDepartment (department)
    cookies.permanent[:remember_department]
  end
  

  def signed_in?
    !current_user.nil?
  end
  

  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def sign_out
    self.current_user = nil
	@current_department = nil
	@current_employee = nil
	session[:dept_name] = nil
    cookies.delete(:remember_token)
	cookies.delete(:remember_department)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath
  end
end
