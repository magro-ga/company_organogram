class EmployeesController < ApplicationController
    before_action :set_company, only: [:index, :create]
    before_action :set_employee, only: [:show, :update, :destroy]
  
    def index
      render json: @company.employees
    end

    def show
      render json: @employee
    end
  
    def create
      employee = @company.employees.new(employee_params)
      if employee.save
        render json: employee, status: :created
      else
        render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @employee.update(employee_params)
        render json: @employee
      else
        render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @employee.destroy
      head :no_content
    end
  
    private
  
    def set_company
      @company = Company.find(params[:company_id])
    end
  
    def set_employee
      @employee = Employee.find(params[:id])
    end
  
    def employee_params
      params.require(:employee).permit(:name, :email, :manager_id)
    end
end
