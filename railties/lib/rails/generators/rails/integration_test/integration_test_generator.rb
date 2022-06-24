# frozen_string_literal: true

module Rails
  module Generators
    class IntegrationTestGenerator < NamedBase # :nodoc:
      hook_for :integration_tool, as: :integration

      # before_generate do |data|
      #   File.write("dummy_file_before.txt", data)
      # end

      after_generate do |data|
        # bin/tapioca dsl ClassName # from data[:generated_class_name]
        puts "RUNNING AFTER_GENERATE HOOK"
        File.write("dummy_file.txt", data)
      end
    end
  end
end
