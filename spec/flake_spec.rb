# frozen_string_literal: true

require 'spec_helper'

describe Flake do
  it 'has a version number' do
    expect(Flake::VERSION).not_to be nil
  end

  before(:all) do
    class AlluvialDamperError < StandardError; end
  end

  describe '.on' do
    context 'with an instance method' do
      before(:all) do
        class HyperdriveMotivator
          def activate_jump(coordinates, &block)
            yield if block
            coordinates.nil? ? :fwooooom! : coordinates
          end
        end

        Flake.on(HyperdriveMotivator, :activate_jump, AlluvialDamperError)
      end

      let(:instantiated) { HyperdriveMotivator.new }
      let(:method_call)  do
        instantiated.activate_jump(:rendezvous_point) { print 'zrrrrpow!' }
      end

      it 'has no class methods' do
        expect(HyperdriveMotivator.methods(false)).to eq([])
      end

      it 'has new instance methods' do
        expect(HyperdriveMotivator.instance_methods(false))
          .to eq([:activate_jump,
                  :__original_activate_jump,
                  :__flaky_activate_jump])
      end

      context 'on the first try' do
        it 'fails with the expected error' do
          expect { method_call }.to raise_error(AlluvialDamperError)
        end
      end

      context 'on the second try' do
        before do
          begin
            method_call
          rescue AlluvialDamperError
            nil
          end
        end

        it 'works this time' do
          expect { method_call }.not_to raise_error(AlluvialDamperError)
        end

        it 'preserves the arguments' do
          expect(method_call).to eq(:rendezvous_point)
        end

        it 'preserves the block' do
          expect { method_call }.to output('zrrrrpow!').to_stdout
        end
      end
    end
  end
end
