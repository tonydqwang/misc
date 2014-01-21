module JobsHelper
  def getJob department
    depart_id = (Department.find_by_name(department.downcase)).id
    @jobRecords = Job.where(department_id: depart_id)
  end
end
