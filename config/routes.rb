SimplestRubyFramework.application.routes do
  get '/tests', 'tests#index', :erb
  post '/tests', 'tests#create', :erb
  get '/tests/:id', 'tests#show', :erb
  get '/tests', 'tests#list', :erb

  get '/api/v1/tests', 'api/v1/tests#index', :erb

  get '/api/v1/health', 'api/v1/health#ping', :jrb
end
# Из двух одинаковых методов всегда будет вызываться первый:
#   get '/tests', 'tests#index'
#   get '/tests', 'tests#list'
