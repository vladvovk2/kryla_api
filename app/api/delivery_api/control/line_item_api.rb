module DeliveryApi
  module Control
    class LineItemApi < Grape::API
      resources :line_items do
        route_param :id do
          params do
            requires :quantity, type: Integer
          end
          patch :quantity do
            line_item = current_cart.line_items.find(params[:id])
            line_item.change_quantity(declared_params[:quantity])
            present_with_entities(line_item)
          end

          delete :destroy do
            line_item = current_cart.line_items.find(params[:id])
            { message: 'Successfully deleted.' } if line_item.destroy
          end
        end
      end
    end
  end
end
