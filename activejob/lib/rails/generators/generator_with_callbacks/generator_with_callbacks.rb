# frozen_string_literal: true

require "rails/generators/named_base"

module Rails # :nodoc:
  module Generators # :nodoc:
    class GeneratorWithCallbacks < Rails::Generators::NamedBase # :nodoc:
      source_root("activejob/lib/rails/generators/generator_with_callbacks/templates")

      after_generate do |files|
        puts "CALLBACK: running bin/tapioca for #{files}"
      end

      def create_file_from_our_template
        Rails::Generators.add_generated_file("our_new_file_path")
      end

      def do_tapioca_stuff
        puts "doing stuff"
        "tapioca_return"
      end

      def command_that_returns_stuff
        "returned_stuff"
      end
    end
  end
end

