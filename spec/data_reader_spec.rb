# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/data_reader'

RSpec.describe DataReader do
    subject { described_class.new(page_visits, unique: unique).call }
  
    describe '#call' do
      context 'with empty visits' do
        let(:page_visits) { {} }
        let(:unique) { false }
  
        it { is_expected.to be_nil }
      end
    end

    describe 'with total visits' do
        let(:unique) { false }
        let(:page_visits) do
            {
              '/index'   => ['444.701.448.104', '444.701.448.104', '126.318.035.038'],
              '/contact' => ['184.123.665.067'],
              '/about'   => ['126.318.035.038'],
              '/about/2' => ['836.973.694.403'],
              '/home'    => ['897.280.786.156', '715.156.286.412']
            }
          end
        let(:expected_output) do
            {
                '/index'   => 3,
                '/home'    => 2,
                '/about'   => 1,
                '/about/2' => 1,
                '/contact' => 1
            }
        end
  
        it { is_expected.not_to be_nil }
        it 'returns the correct values' do
            expect(subject).to eq(expected_output)
          end
      end

      describe 'with unique views' do
        let(:unique) { true }
        let(:page_visits) do
            {
              '/index'   => ['444.701.448.104', '444.701.448.104', '126.318.035.038'],
              '/contact' => ['184.123.665.067'],
              '/about'   => ['126.318.035.038'],
              '/about/2' => ['836.973.694.403'],
              '/home'    => ['897.280.786.156', '715.156.286.412']
            }
          end
        let(:expected_output) do
            {
                '/index'   => 2,
                '/home'    => 2,
                '/about'   => 1,
                '/about/2' => 1,
                '/contact' => 1
            }
        end
  
        it { is_expected.not_to be_nil }
        it 'returns the correct values' do
            expect(subject).to eq(expected_output)
          end
      end
    
end