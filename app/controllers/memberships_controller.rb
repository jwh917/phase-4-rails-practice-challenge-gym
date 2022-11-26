class MembershipsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    memberships = Membership.all
    render json: memberships
  end

  def create
    membership = Membership.create!(mbp_params)
    render json: membership.activity, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end


  private

  def mbp_params
    params.permit(:gym_id, :client_id, :charge)
  end

  def render_not_found_response
    render json: { error: "Membership not found" }, status: :not_found
  end

end