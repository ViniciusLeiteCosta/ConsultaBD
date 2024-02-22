Rails.application.routes.draw do

  root 'home#index'

  resources :pacientes do
    resources :prontuarios
  end

  resources :consultas do
    resources :exames
    resources :prescricoes
  end

  get 'consultas/search', to: 'consultas#search', as: 'search_consultas'
  get '/medicos/search', to: 'medicos#search', as: 'search_medicos'
  get '/pacientes/search', to: 'pacientes#search', as: 'search_pacientes'
  get 'search_prontuarios', to: 'prontuarios#search', as: 'search_prontuarios'
  get 'search_exames', to: 'exames#search'
  resources :medicos
end
