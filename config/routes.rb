Whiteboard::Application.routes.draw do
  get 'boards/:id' => 'boards#show'
  post 'boards' => 'boards#create'
  post 'boards/:id/draw' => 'boards#draw'
  root :to => 'boards#index'
end
