module DeliveryApi
  module Control
    class UserApi < Grape::API
      helpers do
        params :user_params do
          requires :user, type: Hash do
            requires :email,                  type: String, desc: 'User email.'
            requires :phone_number,           type: String, desc: 'User number.'
            requires :first_name,             type: String, desc: 'User nickname.'
            requires :last_name,              type: String, desc: 'User nickname.'
            requires :password,               type: String, desc: 'User password.'
            requires :password_confirmation,  type: String, desc: 'Confirm user password typed above.'
          end
        end
      end

      resources :users do
        get(:all) { present_with_entities(User.all) }

        desc 'User registration form.', entity: DeliveryApi::Entities::UserResponce
        params { use :user_params }
        post :sing_up do
          user = User.new(declared_params[:user])
          if user.save
            { message: 'Done.' }
          else
            error!(user.errors.full_messages)
          end
        end

        delete ':id' do
          User.find(params[:id]).destroy
        end
      end
    end
  end
end
