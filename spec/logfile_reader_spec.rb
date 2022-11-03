# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/logfile_reader'

RSpec.describe FileReader do
  let(:logfile) { './spec/fixtures/webserver_sample.log' }
  subject { described_class.new(logfile) }

  describe 'initialized without logfile' do
    let(:logfile)  { 'fake/path/to/file.log' }
    
    it 'raises an error' do
      expect { subject }
      .to raise_error(ArgumentError, "A log file does not exist")
    end
  end

  describe '#call' do
    before { subject.call }

    let(:expected_results) do
      {
        '/index'   => ['444.701.448.104', '444.701.448.104', '126.318.035.038'],
        '/contact' => ['184.123.665.067'],
        '/about'   => ['126.318.035.038'],
        '/about/2' => ['836.973.694.403'],
        '/home'    => ['897.280.786.156', '715.156.286.412']
      }
    end

    it "reads the data correctly" do
      expect(subject.websites).to eq(expected_results)
    end
  end
end