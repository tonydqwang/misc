module RestrictionsHelper
  def getUserRestriction (user)
    # restriction = Restriction.scoped(:conditions => ["user_id == @user.id"])
	restriction = Restriction.where(user_id: user.id)
	
	
	
	if restriction == []
	  @restriction_msgs = "You do not have any schedule restrictions at this point"
	else
	  @current_restriction = restriction
	end
  end
  
  def current_restriction (restriction)
    @resctriction = Restriction.find_by_id(restriction.id)
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
end
