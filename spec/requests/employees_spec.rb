require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  let(:company) { create(:company) }
  let(:manager) { create(:employee, company: company) }
  let(:employee1) { create(:employee, company: company, manager: manager) }
  let(:employee2) { create(:employee, company: company, manager: manager) }
  let(:subordinate) { create(:employee, company: company, manager: employee1) }  

  before do
    puts "Manager: #{manager.inspect}"
    puts "Employee1: #{employee1.inspect}"
    puts "Employee2: #{employee2.inspect}"
    puts "Subordinate: #{subordinate.inspect}"
  end  

  describe "GET /employees/:id/peers" do
    it "retorna os pares de um colaborador" do
      get "/employees/#{employee1.id}/peers"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(1) # Deve retornar employee2
    end
  end

  describe "GET /employees/:id/direct_reports" do
    it "retorna os liderados diretos de um colaborador" do
      get "/employees/#{manager.id}/direct_reports"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(2) # employee1 e employee2
    end
  end

  describe "GET /employees/:id/second_level_reports" do
    it "retorna os liderados de segundo nível" do
      get "/employees/#{manager.id}/second_level_reports"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq(1) # subordinate
    end
  end
end