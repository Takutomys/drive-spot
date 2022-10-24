Rails.application.routes.draw do

  namespace :public do
    get 'tweets/show'
    get 'tweets/edit'
    get 'tweets/index'
  end
 devise_for :end_users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :public do
        root to: "homes#top"
        get 'end_user/unsubscribe' => "end_users#unsubscribe"
        patch 'end_user/withdraw' => "end_users#withdraw"
        patch 'end_user/release' => "end_users#release"
        patch 'end_user/nonrelease' => "end_users#nonrelease"
        resources :end_users, only: [:show, :edit, :update]
        resources :tweets, only: [:show, :edit, :index, :update, :new, :create, :destroy] do
          resource :favorites, only: [:create, :destroy]
        end  
  end

  devise_scope :end_user do
     post 'end_users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

end
