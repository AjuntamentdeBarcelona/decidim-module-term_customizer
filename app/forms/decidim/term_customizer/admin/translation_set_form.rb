# frozen_string_literal: true

module Decidim
  module TermCustomizer
    module Admin
      class TranslationSetForm < Decidim::Form
        include TranslatableAttributes

        mimic :translation_set

        translatable_attribute :name, String
        attribute :constraints, Array[TermCustomizer::Admin::TranslationSetConstraintForm]
      end
    end
  end
end
