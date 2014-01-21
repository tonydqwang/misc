module AllfilesHelper

  def checkUpload (user)
    allfile = Allfile.find_by_user_id(user.id)
	if allfile != nil
	  @uploadSkip = false
	else
	  @uploadSkip = true
	end
	nil
  end
  
  def getFile (filePath)
    if filePath =~ /.*\/(.*?)/
	  tempPath = $1
	  reutrn tempPath
	end
	return filePath
  end
  
  def sanitize_filename(file_name)
  # get only the filename, not the whole path (from IE)
  just_filename = File.basename(file_name) 
  # replace all none alphanumeric, underscore or perioids
  # with underscore
  just_filename.sub(/[^\w\.\-]/,'_') 
  end
  
end
