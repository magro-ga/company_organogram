require 'rails_helper'

RSpec.describe CompanyService, type: :service do
  let(:valid_attributes) { { name: "Test Company" } }
  let(:invalid_attributes) { { name: nil } }
  let!(:company) { create(:company, name: "Existing Company") }

  describe ".create_company" do
    context "with valid attributes" do
      it "creates a new company" do
        result = CompanyService.create_company(valid_attributes)
        expect(result[:success]).to be true
        expect(result[:company]).to be_persisted
      end
    end

    context "with invalid attributes" do
      it "does not create a new company" do
        result = CompanyService.create_company(invalid_attributes)
        expect(result[:success]).to be false
        expect(result[:errors]).to include("Name can't be blank")
      end
    end
  end

  describe ".find_company" do
    context "when the company exists" do
      it "returns the company" do
        result = CompanyService.find_company(company.id)
        expect(result[:success]).to be true
        expect(result[:company]).to eq(company)
      end
    end

    context "when the company does not exist" do
      it "returns an error" do
        result = CompanyService.find_company(-1)
        expect(result[:success]).to be false
        expect(result[:errors]).to include("Company not found")
      end
    end
  end

  describe ".list_companies" do
    it "returns all companies" do
      result = CompanyService.list_companies
      expect(result[:success]).to be true
      expect(result[:companies]).to include(company)
    end
  end

  describe ".update_company" do
    context "when the company exists" do
      it "updates the company with valid attributes" do
        result = CompanyService.update_company(company.id, { name: "Updated Company" })
        expect(result[:success]).to be true
        expect(result[:company].name).to eq("Updated Company")
      end

      it "does not update the company with invalid attributes" do
        result = CompanyService.update_company(company.id, invalid_attributes)
        expect(result[:success]).to be false
        expect(result[:errors]).to include("Name can't be blank")
      end
    end

    context "when the company does not exist" do
      it "returns an error" do
        result = CompanyService.update_company(-1, valid_attributes)
        expect(result[:success]).to be false
        expect(result[:errors]).to include("Company not found")
      end
    end
  end

  describe ".delete_company" do
    context "when the company exists" do
      it "deletes the company" do
        result = CompanyService.delete_company(company.id)
        expect(result[:success]).to be true
        expect(Company.find_by(id: company.id)).to be_nil
      end
    end

    context "when the company does not exist" do
      it "returns an error" do
        result = CompanyService.delete_company(-1)
        expect(result[:success]).to be false
        expect(result[:errors]).to include("Company not found")
      end
    end
  end
end