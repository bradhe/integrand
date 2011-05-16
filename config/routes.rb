Integrand::Application.routes.draw do
  resources :integrations do
    member do
      post :enqueue
    end
  end

  resources :builds, :only => :show

  root :to => redirect('/integrations')
end
