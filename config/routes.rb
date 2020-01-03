Rails.application.routes.draw do
  constraints(->(req) {req.env["HTTP_USER_AGENT"] =~ /Chrome/}) do
    get 'admin' => 'admin#index'
    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
    end

    get 'sessions/create'
    get 'sessions/destroy'
    resources :users do
      get 'my-orders' => 'users#orders', on: :collection
      get 'my-items' => 'users#line_items', on: :collection
    end
    resources :products, :path => 'books' do
      get :who_bought, on: :member
    end

    namespace :admin do
      get 'reports' => 'reports#index'
      post 'reports', to: 'reports#index'
      resources :categories do
        get 'books' => 'products#index', constraints: {category_id: /\d+/}
        get 'books', to: redirect('/admin/reports'), constraints: {category_id: /[A-Za-z]/}
      end
    end
    resources :support_requests, only: [ :index, :update ]
    scope '(:locale)' do
      resources :orders
      resources :line_items
      resources :carts
    end
  end
  root 'store#index', as: 'store_index', via: :all  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
