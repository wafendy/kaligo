class SuppliersController < ApplicationController
  def index
    suppliers = Supplier.all
    render json: SupplierSerializer.new(suppliers).serialized_json
  end
end