# frozen_string_literal: true

# Module included in the target class. Generates a new method with the
# appropriate flakiness parameters, then replaces the original with it with the
# .flakify method.
module Flakifier
  # TODO: Add ability to supply number of retries
  def flakify(method_name, error)
    alias_method __original_method_name(method_name), method_name

    class_eval(__flaky_method(method_name, error))

    alias_method method_name, __flaky_method_name(method_name)

    self
  end

  private

  def __original_method_name(method_name)
    '__original_' + method_name.to_s
  end

  def __flaky_method_name(method_name)
    '__flaky_' + method_name.to_s
  end

  def __flaky_method(method_name, error)
    "def #{__flaky_method_name(method_name)}(*args, &block);
       @__flaky_method_call_count ||= 0;
       while @__flaky_method_call_count < 1;
         @__flaky_method_call_count += 1;
         raise #{error};
         return;
       end;

        #{__original_method_name(method_name)}(*args, &block);
       end;"
  end
end
