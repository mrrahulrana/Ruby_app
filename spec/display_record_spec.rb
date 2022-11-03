# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/display_record'

RSpec.describe DisplayRecord do
    subject { described_class.new(page_visits, information).call }
  
    describe '#call' do
      context 'with invalid log output' do
        let(:page_visits) { nil }
        let(:information) { '' }
  
        it 'prints out error message' do
          expect { subject }.to output('Please provide valid input.').to_stdout
        end
      end
  
      context 'with sample log output' do
        let(:page_visits) do 
            { 
            '/index'   => 3
            }
        end
        let(:information) { 'visits' }
  
        it { is_expected.to be_nil }
  
        it 'prints out results' do
          expect { subject }.to output("-----------visits-----------\n/index - 3 visits\n").to_stdout
        end
      end
    end
  end