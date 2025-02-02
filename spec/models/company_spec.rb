require 'rails_helper'

RSpec.describe Company, type: :model do
  it "é válido com um nome" do
    company = Company.new(name: "Empresa X")
    expect(company).to be_valid
  end

  it "é inválido sem um nome" do
    company = Company.new(name: nil)
    expect(company).not_to be_valid
  end

  it "não permite nomes duplicados" do
    Company.create!(name: "Empresa X")
    duplicate = Company.new(name: "Empresa X")
    expect(duplicate).not_to be_valid
  end
end
