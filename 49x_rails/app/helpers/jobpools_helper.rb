module JobpoolsHelper
  def getPool department
  
    depart_id = (Department.find_by_name(department.downcase)).id
    @poolRecords = Pool.where(department_id: depart_id)
    
  end

  def getJobpool poolid
    @jobpoolRecords = Jobpool.where(pool_id: poolid)
  end
  
  def getJob jobid
    @jobRecords = Job.where(id: jobid)
  end
  
end
