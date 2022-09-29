Rails.application.routes.draw do
 devise_for :end_users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
        root to: "homes#top"
        resource :end_users, only: [:show, :edit, :update, :unsubscribe, :withdraw]
  end
end
