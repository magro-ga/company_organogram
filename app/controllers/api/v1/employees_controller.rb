module Api
  module V1
    class EmployeesController < ApplicationController
      before_action :set_company
      before_action :set_employee, only: [:show, :destroy, :peers, :direct_reports, :second_level_reports]

      def index
        if params[:company_id]
          @company = Company.find(params[:company_id])
          result = EmployeeService.list_employees(@company)
        else
          result = EmployeeService.list_employees
        end

        if result[:success]
          render json: result[:employees]
        else
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        end
      end

      def show
        render json: @employee
      end

      def create
        result = EmployeeService.create_employee(@company, employee_params)
        if result[:success]
          render json: result[:employee], status: :created
        else
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        end
      end

      def update
        result = EmployeeService.update_employee(@employee, employee_params)
        if result[:success]
          render json: result[:employee]
        else
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        end
      end

      def destroy
        EmployeeService.delete_employee(@employee)
        head :no_content
      end

      def peers
        if @employee.manager.nil?
          render json: []
        else
          peers = @employee.manager.subordinates.where.not(id: @employee.id)
          render json: peers
        end
      end

      def direct_reports
        render json: @employee.subordinates
      end

      def second_level_reports
        second_level_reports = @employee.subordinates.flat_map(&:subordinates)
        render json: second_level_reports
      end

      private

      def set_company
        @company = Company.find(params[:company_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Company not found' }, status: :not_found
      end

      def set_employee
        @employee = @company.employees.find_by(id: params[:id])
        render json: { error: 'Employee not found' }, status: :not_found if @employee.nil?
      end

      def employee_params
        params.require(:employee).permit(:name, :email, :manager_id)
      end
    end
  end
end
