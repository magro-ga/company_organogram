class EmployeeService
  def self.create_employee(company, params)
    manager = Employee.find_by(id: params[:manager_id])

    if manager && manager.company_id != company.id
      return { success: false, errors: ["Manager must belong to the same company"] }
    end

    employee = company.employees.new(params)
    if employee.save
      { success: true, employee: employee }
    else
      { success: false, errors: employee.errors.full_messages }
    end
  end

  def self.update_employee(employee, params)
    if employee.update(params)
      { success: true, employee: employee }
    else
      { success: false, errors: employee.errors.full_messages }
    end
  end

  def self.delete_employee(employee)
    employee.destroy
    { success: true }
  end

  def self.find_employee(id)
    employee = Employee.find_by(id: id)
    if employee
      { success: true, employee: employee }
    else
      { success: false, errors: ["Employee not found"] }
    end
  end

  def self.list_employees
    { success: true, employees: Employee.all }
  end

  def self.peers(employee)
    return { success: true, peers: [] } unless employee.manager

    peers = employee.manager.subordinates.where.not(id: employee.id)
    { success: true, peers: peers }
  end

  def self.direct_reports(employee)
    { success: true, direct_reports: employee.subordinates }
  end

  def self.second_level_reports(employee)
    second_level_reports = employee.subordinates.flat_map(&:subordinates)
    { success: true, second_level_reports: second_level_reports }
  end
end
