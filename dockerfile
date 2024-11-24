# Usar uma imagem base do Ruby
FROM ruby:3.2.2

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Definir o diretório de trabalho
WORKDIR /app

# Copiar Gemfile e instalar as gems
COPY Gemfile* ./
RUN bundle install

# Copiar os arquivos do projeto
COPY . .

# Expõe a porta da aplicação
EXPOSE 3000

# Comando de inicialização
CMD ["rails", "server", "-b", "0.0.0.0"]
