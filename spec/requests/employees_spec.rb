require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  let(:company) { create(:company) }
  let(:manager) { create(:employee, company: company) }
  let(:employee1) { create(:employee, company: company, manager: manager) }
  let(:employee2) { create(:employee, company: company, manager: manager) }
  let(:subordinate) { create(:employee, company: company, manager: employee1) }

  describe "GET /api/v1/employees/:id/peers" do
    it "returns the peers of an employee" do
      get "/api/v1/employees/#{employee1.id}/peers"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(1) # Should return employee2
    end
  end

  describe "GET /api/v1/employees/:id/direct_reports" do
    it "returns the direct reports of an employee" do
      get "/api/v1/employees/#{manager.id}/direct_reports"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(2) # employee1 and employee2
    end
  end

  describe "GET /api/v1/employees/:id/second_level_reports" do
    it "returns the second level reports of an employee" do
      get "/api/v1/employees/#{manager.id}/second_level_reports"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(1) # subordinate
    end
  end
end