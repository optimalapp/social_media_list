Rails.application.routes.draw do
  root "posts#index"
  post "network_sort", to: "posts#network_sort", as: "network_sort"
  post "list_sort", to: "posts#list_sort", as: "list_sort"
end
