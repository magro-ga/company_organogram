module Types
  class MutationType < Types::BaseObject
    field :create_company, Types::CompanyType, null: false do
      argument :name, String, required: true
    end

    field :update_company, Types::CompanyType, null: false do
      argument :id, ID, required: true
      argument :name, String, required: false
    end

    field :delete_company, Boolean, null: false do
      argument :id, ID, required: true
    end

    field :create_employee, Types::EmployeeType, null: false do
      argument :company_id, ID, required: true
      argument :name, String, required: true
      argument :email, String, required: true
      argument :manager_id, ID, required: false
    end

    field :update_employee, Types::EmployeeType, null: false do
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false
      argument :manager_id, ID, required: false
    end

    field :delete_employee, Boolean, null: false do
      argument :id, ID, required: true
    end

    def create_company(name:)
      result = CompanyService.create_company({ name: name })
      return result[:company] if result[:success]

      GraphQL::ExecutionError.new(result[:errors].join(", "))
    end

    def update_company(id:, name:)
      company = Company.find_by(id: id)
      return GraphQL::ExecutionError.new("Company not found") if company.nil?

      result = CompanyService.update_company(company, { name: name })
      return result[:company] if result[:success]

      GraphQL::ExecutionError.new(result[:errors].join(", "))
    end

    def delete_company(id:)
      company = Company.find_by(id: id)
      return GraphQL::ExecutionError.new("Company not found") if company.nil?

      CompanyService.delete_company(company)
      true
    end

    def create_employee(company_id:, name:, email:, manager_id: nil)
      company = Company.find_by(id: company_id)
      return GraphQL::ExecutionError.new("Company not found") if company.nil?
    
      result = EmployeeService.create_employee(company, { name: name, email: email, manager_id: manager_id })
      return result[:employee] if result[:success]

      GraphQL::ExecutionError.new(result[:errors].join(", "))
    end

    def update_employee(id:, name: nil, email: nil, manager_id: nil)
      employee = Employee.find_by(id: id)
      return GraphQL::ExecutionError.new("Employee not found") if employee.nil?

      result = EmployeeService.update_employee(employee, { name: name, email: email, manager_id: manager_id })
      return result[:employee] if result[:success]

      GraphQL::ExecutionError.new(result[:errors].join(", "))
    end

    def delete_employee(id:)
      employee = Employee.find_by(id: id)
      return GraphQL::ExecutionError.new("Employee not found") if employee.nil?

      EmployeeService.delete_employee(employee)
      true
    end
  end
end
