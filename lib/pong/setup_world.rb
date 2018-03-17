# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize

module Pong
  # Setup script
  class SetupWorld
    attr_reader :world

    def initialize(world:)
      @world = world
    end

    def call
      create_player(:left)
      create_player(:right)

      create_platform(:left)
      create_platform(:right)

      create_ball

      world.add_system(Pong::Systems::RenderRectangle.new)
    end

    private

    def create_player(side)
      world.create_entity(:"#{side}_player")
    end

    def create_platform(side)
      platform = world.create_entity(:"#{side}_platform")
      add_component(platform, Components::Rectangle[
        x: platform_x(side),
        y: platform_y,
        width: platform_width,
        height: platform_height
      ])
    end

    def create_ball
      ball = world.create_entity(:ball)
      add_component(ball, Components::Rectangle[
        x: world.width / 2,
        y: world.height / 2,
        width: world.width / 100 * 1,
        height: world.width / 100 * 1
      ])
    end

    def add_component(entity, component)
      world.entity_registry.add_component(entity, component)
    end

    def platform_x(side)
      case side
      when :left
        0
      when :right
        world.width - platform_width
      end
    end

    def platform_y
      world.height / 2 - platform_height / 2
    end

    def platform_width
      world.width / 100 * 1
    end

    def platform_height
      world.height / 100 * 10
    end
  end
end
# rubocop:enable Metrics/AbcSize