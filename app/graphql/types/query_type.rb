module Types
  class QueryType < Types::BaseObject
    field :companies, [Types::CompanyType], null: false
    field :company, Types::CompanyType, null: false do
      argument :id, ID, required: true
    end

    field :employees, [Types::EmployeeType], null: false
    field :employee, Types::EmployeeType, null: false do
      argument :id, ID, required: true
    end

    field :peers, [Types::EmployeeType], null: false do
      argument :id, ID, required: true
    end

    field :direct_reports, [Types::EmployeeType], null: false do
      argument :id, ID, required: true
    end

    field :second_level_reports, [Types::EmployeeType], null: false do
      argument :id, ID, required: true
    end

    def companies
      Company.all
    end

    def company(id:)
      Company.find(id)
    end

    def employees
      Employee.all
    end

    def employee(id:)
      Employee.find(id)
    end

    def peers(id:)
      employee = Employee.find(id)
      employee.manager ? employee.manager.subordinates.where.not(id: id) : []
    end

    def direct_reports(id:)
      Employee.find(id).subordinates
    end

    def second_level_reports(id:)
      Employee.find(id).subordinates.flat_map(&:subordinates)
    end
  end
end
