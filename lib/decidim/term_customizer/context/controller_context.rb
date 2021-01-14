# frozen_string_literal: true

module Decidim
  module TermCustomizer
    module Context
      class ControllerContext < Base
        def resolve!
          env = data[:headers].env
          controller = env["action_controller.instance"]

          @organization = env["decidim.current_organization"]

          # E.g. at the participatory process controller the
          # `decidim.current_participatory_space` environment variable has not
          # been set. Therefore, we need to fetch it directly from the
          # controller using its private method. In some edge cases this may not
          # be implemented (https://github.com/mainio/decidim-module-term_customizer/issues/28)
          # in which case we do not have access to the participatory space.
          unless controller.respond_to?(:current_participatory_space)
            controller.define_singleton_method(:public_current_participatory_space) do
              current_participatory_space if self.respond_to? :current_participatory_space, true
            end
            @space = controller.public_current_participatory_space
          else
            @space = controller.try(:current_participatory_space)
          end
          @space ||= env["decidim.current_participatory_space"]

          @component = env["decidim.current_component"]
        end
      end
    end
  end
end
