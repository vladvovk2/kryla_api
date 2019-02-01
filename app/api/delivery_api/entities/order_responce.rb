module DeliveryApi
  module Entities
    class OrderResponce < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.strftime("%B %d, %Y") }

      expose :name,        documentation: { type: 'string',  values: ['Vlad Vovk'] }
      expose :adress,      documentation: { type: 'string',  values: ['Gogolya, 24'] }
      expose :user_number, documentation: { type: 'string',  values: ['0687285102'] }
      expose :total_price, documentation: { type: 'string',  values: ['312'] }

      with_options(expose_nil: false) do
        expose :description, documentation: { type: 'string',  values: ['Сall me back when you drive up.'] } 
      end

      with_options(format_with: :iso_timestamp) do
        expose :created_at, documentation: { type: 'string', values: ['January 10, 2019'] }
      end
    end
  end
end