# frozen_string_literal: true

module RubyNext
  module Language
    module Rewriters
      class MethodReference < Text
        NAME = "method-reference"
        SYNTAX_PROBE = "Language.:transform"
        MIN_SUPPORTED_VERSION = Gem::Version.new(RubyNext::NEXT_VERSION)

        def rewrite(source)
          source.gsub(/\.:([\w_]+)/) do |match|
            context.track! self

            ".method(:#{$1})"
          end
        end
      end
    end
  end
end
