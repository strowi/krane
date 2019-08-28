# frozen_string_literal: true
require 'test_helper'
require 'krane/cli/krane'

class KraneTest < KubernetesDeploy::TestCase
  def test_version_prints_current_version
    assert_output(nil, /Krane Version: #{KubernetesDeploy::VERSION}/) { krane.version }
  end

  def test_version_success_as_black_box
    out, err, status = krane_black_box
    assert_predicate(status, :success?)
    assert_empty(out)
    assert_match(KubernetesDeploy::VERSION, err)
  end

  def test_version_failure_as_black_box
    out, err, status = krane_black_box("-q")
    assert_equal(status.exitstatus, 1)
    assert_empty(out)
    assert_match("ERROR", err)
  end

  private

  def krane
    Krane::CLI::Krane.new
  end

  def krane_black_box(args = "")
    path = File.expand_path("../../../exe/krane", __FILE__)
    Open3.capture3("#{path} version #{args}")
  end
end
