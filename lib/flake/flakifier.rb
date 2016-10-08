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
    "__original_".concat(method_name.to_s).to_sym
  end

  def __flaky_method_name(method_name)
    "__flaky_".concat(method_name.to_s).to_sym
  end

  def __flaky_method(method_name, error)
    "def #{__flaky_method_name(method_name)}(*args, &block);
       @__flaky_method_call_count ||= 0;
       while @__flaky_method_call_count < 1;
         @__flaky_method_call_count += 1;
         raise #{error.to_s};
         return;
       end;

        #{__original_method_name(method_name)}(*args, &block);
       end;"
  end
end
