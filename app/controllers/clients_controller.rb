class ClientsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    clients = Client.all
    render json: clients
  end

  def show
    client = find_clt
    render json: client, include: :memberships
  end
  
  def create
    client = Client.create!(clt_params)
    render json: client.activity, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def update
    client = find_clt
    client.update(clt_params)
    render json: client
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end 

  def destroy
    client = find_clt
    client.destroy
    head :no_content
  end

  private 
  
  def find_clt
    Client.find(params[:id])
  end

  def clt_params
    params.permit(:name, :age)
  end

  def render_not_found_response
    render json: { error: "Gym not found" }, status: :not_found
  end

end