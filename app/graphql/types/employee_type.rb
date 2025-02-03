module Types
  class EmployeeType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :company, Types::CompanyType, null: false
    field :manager, Types::EmployeeType, null: true
    field :subordinates, [Types::EmployeeType], null: true
  end
end
