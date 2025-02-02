class EmployeesController < ApplicationController
  before_action :set_company, only: [:index, :create]
  before_action :set_employee, only: [:show, :update, :destroy, :peers, :direct_reports, :second_level_reports]

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

  def peers
    if @employee.manager.nil?
      render json: []
    else
      peers = @employee.manager.subordinates.where.not(id: @employee.id)
      puts "Peers: #{peers.inspect}"
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
  end

  def set_employee
    @employee = Employee.find_by(id: params[:id])
    render json: { error: 'Employee not found' }, status: :not_found if @employee.nil?
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :manager_id)
  end
end
