require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:company) { create(:company) }
  let(:manager) { create(:employee, company: company, manager: nil) }
  let(:employee) { build(:employee, company: company, manager: manager) }

  it "é válido com nome, email e empresa" do
    expect(employee).to be_valid
    employee.save!
    expect(employee.persisted?).to be true
  end

  it "é inválido sem nome" do
    invalid_employee = build(:employee, name: nil, company: company, manager: manager)
    expect(invalid_employee).not_to be_valid
  end

  it "é inválido sem email" do
    invalid_employee = build(:employee, email: nil, company: company, manager: manager)
    expect(invalid_employee).not_to be_valid
  end

  it "impede loops na hierarquia (um gestor não pode ser liderado por seu próprio subordinado)" do
    employee.save!
    subordinate = create(:employee, company: company, manager: employee)
    employee.manager = subordinate
    expect(employee).not_to be_valid
  end
end