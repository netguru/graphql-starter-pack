# frozen_string_literal: true

class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def index
    render plain: "hello"
  end

  def execute
    # simple_query_scenario
    # query = params[:query]
    # result = FashionStoreSchema.execute(query)
    # render json: result
  rescue StandardError => e
    handle_error e
  end

 # scenario_10
 # context = { current_user: current_user }
 # result = FashionStoreSchema.execute(query, context: context)

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error(err)
    if Rails.env.development?
      logger.error err.message
      logger.error err.backtrace.join(" ")
    end

    if err.is_a?(Authorization::Error)
      status = 401
    else
      status = 500
    end

    render json: {error: {message: err.message}, data: {}}, status: status
  end
end
