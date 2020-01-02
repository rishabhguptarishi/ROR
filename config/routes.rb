Rails.application.routes.draw do
  get 'admin' => 'admin#index', constraints: {user_agent: /Chrome/}
  controller :sessions do
    get 'login' => :new, constraints: {user_agent: /Chrome/}
    post 'login' => :create, constraints: {user_agent: /Chrome/}
    delete 'logout' => :destroy, constraints: {user_agent: /Chrome/}
  end

  get 'sessions/create', constraints: {user_agent: /Chrome/}
  get 'sessions/destroy', constraints: {user_agent: /Chrome/}
  resources :users, constraints: {user_agent: /Chrome/} do
    get 'my-orders' => 'users#orders', on: :collection
    get 'my-items' => 'users#line_items', on: :collection
  end
  resources :products, :path => 'books', constraints: {user_agent: /Chrome/} do
    get :who_bought, on: :member
  end

  namespace :admin, constraints: {user_agent: /Chrome/} do
    get 'reports' => 'reports#index'
    post 'reports', to: 'reports#index'
    resources :categories do
      get 'books' => 'products#index', constraints: {category_id: /\d+/}
      get 'books', to: redirect('/admin/reports'), constraints: {category_id: /[A-Za-z]/}
    end
  end

  resources :support_requests, only: [ :index, :update ], constraints: {user_agent: /Chrome/}
  scope '(:locale)' do
    resources :orders, constraints: {user_agent: /Chrome/}
    resources :line_items, constraints: {user_agent: /Chrome/}
    resources :carts, constraints: {user_agent: /Chrome/}
    root 'store#index', as: 'store_index', via: :all
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
