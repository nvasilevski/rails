# frozen_string_literal: true

require "generators/generators_test_helper"
require "rails/generators/generator_with_callbacks/generator_with_callbacks"

class GeneratorWithCallbacksTest < Rails::Generators::TestCase
  include GeneratorsTestHelper

  def test_job_skeleton_is_created
    run_generator ["hey_from_test"]
  end
end
