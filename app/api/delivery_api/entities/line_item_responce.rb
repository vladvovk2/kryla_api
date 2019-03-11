module DeliveryApi
  module Entities
    class LineItemResponce < Grape::Entity
      expose :id, documentation: { type: 'Integer', values: ['2'] }
      expose :product_type_id,
             documentation: { type: 'String', values: ['Potato'] },
             as: :title
      expose :quantity,     documentation: { type: 'Integer', values: ['10'] }
      expose :price,        documentation: { type: 'Integer', values: ['10'] }
      expose :total_price,  documentation: { type: 'Integer', values: ['100'] }

      private

      def price
        product_type.price
      end

      def product_type_id
        product_type.product.title
      end

      def total_price
        price * object.quantity
      end

      def product_type
        object.product_type
      end
    end
  end
end
