require "flake/flakifier"

module Flake
  VERSION = "0.0.1"

  extend self

  # TODO: Adapt to class methods.
  def on(target_class, target_method, error)
    patch = patching_code(target_method, error)
    target_class.class_eval(patch)
  end

  private

  def patching_code(target_method, error)
    "extend Flakifier; flakify :#{target_method.to_s}, #{error.to_s}"
  end
end
