module UsersHelper
  
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag("default.jpg", alt: user.name, class: "gravatar")
  end
  
  def indepart (user)
    department = Department.find_by_user_id(user.id)
	if department != nil
	  @skip = false
	else
	  @skip = true
	end
	nil
  end

  def checkUpload (user)
    allfile = Allfile.find_by_user_id(user.id)
	if allfile != nil
	  @uploadSkip = false
	else
	  @uploadSkip = true
	end
	nil
  end
  
  def isAdmin (user)
    @adminCheck = user.admin
	nil
  end
  
  def thisUser (user)
    @item = user
    session[:user_for_dept] = @item
  end
  
  def thisFile (user)
    @item_2 = user
    session[:user_file] = Allfile.find_by_user_id(user.id)
  end

end
