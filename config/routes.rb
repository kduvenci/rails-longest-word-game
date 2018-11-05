Rails.application.routes.draw do
  get '/', to: 'games#new'
  get 'new', to: 'games#new', as: :new
  post 'score', to: 'games#score', as: :score
end
