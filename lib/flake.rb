# frozen_string_literal: true
require 'flake/version'
require 'flake/flakifier'

# Utility module to clobber methods.
module Flake
  def self.on(target_class, target_method, error)
    patch = patching_code(target_method, error)
    target_class.class_eval(patch)
  end

  class << self
    private

    def patching_code(target_method, error)
      "extend Flakifier; flakify :#{target_method}, #{error}"
    end
  end
end
