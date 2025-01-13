# frozen_string_literal: true

DIR_NAME = File.dirname(__FILE__)
$:.unshift File.join(DIR_NAME, "..", "lib")

require 'test/unit'
require 'debase/ruby_core_source'

class DeduceSourceDirTest < Test::Unit::TestCase

  def test_deduce_source_dir
    version_to_answer = {
      "3.4.1" => "ruby-3.4.0-p-1",
      "3.4.0" => "ruby-3.4.0-p-1",
      "3.3.6" => "ruby-3.3.5-p100",
      "3.3.5" => "ruby-3.3.5-p100",
      "3.3.4" => "ruby-3.3.0-p0",
      "3.3.3" => "ruby-3.3.0-p0",
      "3.2.6" => "ruby-3.2.0-p0",
      "3.1.6" => "ruby-3.1.0-p0",
      "3.0.7" => "ruby-3.0.0-p0",
    }

    version_to_answer.each do |version, answer|
      ENV[Debase::RubyCoreSource::MOCK_RUBY_VERSION_KEY] = version
      result = Debase::RubyCoreSource.deduce_packaged_source_dir(version)
      deduced_source_dir_name = result.split(File::SEPARATOR).last
      assert_equal(answer, deduced_source_dir_name)
    end
  end
end
