class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActionController::ParameterMissing, with: :render_bad_request_response

  def render_not_found_response(error)
    render json: { errors: { base: [error.message] } }, status: :not_found
  end

  def render_bad_request_response(error)
    render json: { errors: { base: [error.message] } }, status: :unprocessable_entity
  end
end
