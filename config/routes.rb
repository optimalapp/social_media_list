Rails.application.routes.draw do
  root "posts#index"
  post "network_sort", to: "posts#network_sort", as: "network_sort"
  post "list_sort", to: "posts#list_sort", as: "list_sort"

  post "date_range_sort", to: "posts#date_range_sort", as: "date_range_sort"
  post "text_search", to: "posts#text_search", as: "text_search"
end
