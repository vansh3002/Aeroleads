Rails.application.routes.draw do
  root "dialer#index"

  resources :blogs do
    collection do
      post :ai_generate
    end
  end

  resources :dialer, only: [:index] do
    collection do
      post :upload_numbers
      post :start_calls
      post :ai_command
      delete :delete_logs
      get :fetch_logs     
    end
  end

  post '/twilio/voice' => 'twilio#voice'
  post '/twilio/status' => 'twilio#status'
end
