Rails.application.routes.draw do

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
        patch 'end_user/withdraw' => "end_users#withdraw"
        patch 'end_user/release' => "end_users#release"
        patch 'end_user/nonrelease' => "end_users#nonrelease"
        resources :end_users, only: [:show, :edit, :update] do
          member do
            get :follows, :followers
           end
           resource :follows, only: [:create, :destroy]
        end
        resources :tweets, only: [:show, :edit, :index, :update, :new, :create, :destroy] do
          resource :favorites, only: [:create, :destroy]
          resources :comments, only: [:create, :destroy]
        end
  end

  namespace :admin do
    resources :end_users, only: [:show, :index, :edit, :update]
  end

  devise_scope :end_user do
     post 'end_users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

end
