require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:company) { create(:company) }
  let(:manager) { create(:employee, company: company, manager: nil) }
  let(:employee) { build(:employee, company: company, manager: manager) }

  it "is valid with name, email, and company" do
    expect(employee).to be_valid
    employee.save!
    expect(employee.persisted?).to be true
  end

  it "is invalid without a name" do
    invalid_employee = build(:employee, name: nil, company: company, manager: manager)
    expect(invalid_employee).not_to be_valid
  end

  it "is invalid without an email" do
    invalid_employee = build(:employee, email: nil, company: company, manager: manager)
    expect(invalid_employee).not_to be_valid
  end

  it "prevents hierarchy loops (a manager cannot be led by their own subordinate)" do
    employee.save!
    subordinate = create(:employee, company: company, manager: employee)
    employee.manager = subordinate
    expect(employee).not_to be_valid
  end
end