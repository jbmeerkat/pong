# frozen_string_literal: true

require 'securerandom'

module ECS
  # Basic component
  class Component < Dry::Struct::Mutable
    # Basic component types
    module Types
      include Dry::Types.module

      Id = Types::String.default { SecureRandom.uuid }
    end

    constructor_type :strict_with_defaults

    attribute :id, Types::Id

    def name
      self.class.name.split('::').last.downcase.to_sym
    end
  end
end