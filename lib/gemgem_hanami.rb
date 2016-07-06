require 'hanami/model'
require 'hanami/mailer'
Dir["#{ __dir__ }/gemgem_hanami/**/*.rb"].each { |file| require_relative file }

Hanami::Model.configure do
  ##
  # Database adapter
  #
  # Available options:
  #
  #  * Memory adapter
  #    adapter type: :memory, uri: 'memory://localhost/gemgem_hanami_development'
  #
  #  * SQL adapter
  #    adapter type: :sql, uri: 'sqlite://db/gemgem_hanami_development.sqlite3'
  #    adapter type: :sql, uri: 'postgres://localhost/gemgem_hanami_development'
  #    adapter type: :sql, uri: 'mysql://localhost/gemgem_hanami_development'
  #
  # adapter type: :sql, uri: ENV['GEMGEM_HANAMI_DATABASE_URL']
  adapter type: :sql, uri: "postgres://nick:blabla@localhost/sheets"

  ##
  # Migrations
  #
  migrations 'db/migrations'
  schema     'db/schema.sql'

  ##
  # Database mapping
  #
  # Intended for specifying application wide mappings.
  #
  # You can specify mapping file to load with:
  #
  # mapping "#{__dir__}/config/mapping"
  #
  # Alternatively, you can use a block syntax like the following:
  #
  mapping do
    # collection :users do
    #   entity     User
    #   repository UserRepository
    #
    #   attribute :id,   Integer
    #   attribute :name, String
    # end
  end
end.load!

Hanami::Mailer.configure do
  root "#{ __dir__ }/gemgem_hanami/mailers"

  # See http://hanamirb.org/guides/mailers/delivery
  delivery do
    development :test
    test        :test
    # production :stmp, address: ENV['SMTP_PORT'], port: 1025
  end
end.load!



# FIXME: my initializers don't get loaded.

require "disposable/twin/property/hash"

require "reform/form/dry"
Reform::Form.class_eval do
  feature Reform::Form::Dry
end

