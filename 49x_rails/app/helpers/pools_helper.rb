module PoolsHelper
  def getPool department
    depart_id = (Department.find_by_name(department.downcase)).id
    @poolRecords = Pool.where(department_id: depart_id)
  end
end
