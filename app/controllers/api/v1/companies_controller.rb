module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :set_company, only: [:show]

      def index
        companies = Company.all
        render json: companies
      end

      def show
        render json: @company
      end

      def create
        result = CompanyService.create_company(company_params)

        if result[:success]
          render json: result[:company], status: :created
        else
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        end
      end

      private

      def set_company
        @company = Company.find_by(id: params[:id])
        render json: { error: 'Company not found' }, status: :not_found unless @company
      end

      def company_params
        params.require(:company).permit(:name)
      end
    end
  end
end
