source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

# Framework Rails
gem 'rails', '~> 6.1.7', '>= 6.1.7.6'

# Banco de dados
gem 'pg', '~> 1.1'

# Servidor de aplicação
gem 'puma', '~> 5.0'

# Debugging e utilitários
gem 'byebug', platforms: [:mri, :mingw, :x64_mingw], group: [:development, :test]
gem 'listen', '~> 3.3', group: :development
gem 'dotenv-rails', groups: [:development, :test] # Gerenciamento de variáveis de ambiente

# Testes
gem 'rspec-rails', group: [:development, :test] # Framework principal de testes
gem 'factory_bot_rails', '~> 6.1', group: [:development, :test]
gem 'faker', group: [:development, :test] # Geração de dados fictícios
gem 'simplecov', require: false, group: :test # Cobertura de testes

# Performance e otimização
gem 'bullet', group: :development # Detecção de consultas N+1
gem 'rack-mini-profiler', group: :development # Identificação de gargalos
gem 'pg_search' # Busca full-text otimizada

# APIs e serialização
gem 'jbuilder' # Geração de JSON de forma flexível
gem 'rswag' # Documentação de APIs com Swagger

# Background Jobs (opcional para tarefas assíncronas)
gem 'sidekiq' # Gerenciamento de filas de jobs assíncronos

# Boas práticas
gem 'rubocop', require: false, group: [:development, :test] # Linter para manter padrões de estilo
gem 'brakeman', require: false, group: :development # Scanner de segurança

# Paginador
gem 'kaminari' # Paginador flexível e personalizável
gem 'nokogiri', '~> 1.13', '>= 1.13.10'

# Windows
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# 6. Gems Extras para Destaque
# roo: Caso precise importar/exportar dados de simulações em planilhas (CSV, Excel).
# prawn: Para exportar relatórios de simulações em PDF, caso queira adicionar essa funcionalidade.
# chartkick: Gera gráficos para visualizações de dados (ex.: evolução de empréstimos).
