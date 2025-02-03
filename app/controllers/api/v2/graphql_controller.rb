# app/controllers/api/v2/graphql_controller.rb
module Api
  module V2
    class GraphqlController < ApplicationController
      def execute
        variables = prepare_variables(params[:variables])
        query = params[:query]
        operation_name = params[:operationName]
        context = {}

        result = CompanyOrganogramSchema.execute(
          query, variables: variables, context: context, operation_name: operation_name
        )

        render json: result
      rescue StandardError => e
        handle_error_in_development(e)
      end

      private

      def prepare_variables(variables_param)
        case variables_param
        when String
          variables_param.present? ? JSON.parse(variables_param) : {}
        when Hash, ActionController::Parameters
          variables_param.to_unsafe_hash
        when nil
          {}
        else
          raise ArgumentError, "Unexpected parameter: #{variables_param}"
        end
      end

      def handle_error_in_development(e)
        logger.error e.message
        logger.error e.backtrace.join("\n")
        render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
      end
    end
  end
end
