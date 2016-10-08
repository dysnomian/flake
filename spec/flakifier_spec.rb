# frozen_string_literal: true

require 'spec_helper'

class ExhaustPortError < StandardError; end

describe Flakifier do
  describe 'flakify' do
    let(:klass) do
      Class.new do
        extend Flakifier

        def fire_main_cannon
          :boom
        end
        flakify(:fire_main_cannon, ExhaustPortError)

        def power_down
          :nope
        end
      end
    end

    let(:instantiated) { klass.new }

    it 'replaces the method with a flaky one' do
      expect { instantiated.fire_main_cannon }
        .to raise_error(ExhaustPortError)
    end

    context 'on the second try' do
      before do
        begin
          instantiated.fire_main_cannon
        rescue ExhaustPortError; nil
        end
      end

      it 'behaves normally' do
        expect(instantiated.fire_main_cannon).to eq(:boom)
      end
    end
  end
end
