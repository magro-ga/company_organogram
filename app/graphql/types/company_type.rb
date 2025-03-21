module Types
  class CompanyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :employees, [Types::EmployeeType], null: true
  end
end
