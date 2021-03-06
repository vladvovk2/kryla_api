module DeliveryApi
  module Controllers
    class PhoneVerificationApi < Root
      helpers do
        def verification_code
          rand(1000..9999)
        end
      end

      resources :phone_verification do
        before { authenticate! }

        desc 'Send to user verification code.'
        get :message do
          code = verification_code

          SendVerificationMessageJob.perform_later(
            number: current_user.phone_number,
            code: code
          )

          present(verification_code: code)
        end

        desc 'Activation account with verification code.'
        params { requires :validation, type: Boolean }
        patch :confirmation do
          return present(message: 'Already verify!') if current_user.verification

          present(status: true) if current_user.verify(declared_params[:validation])
        end
      end
    end
  end
end
