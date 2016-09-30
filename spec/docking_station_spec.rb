require 'spec_helper'

describe DockingStation do

  describe 'initialization' do
    subject { DockingStation.new }
    let(:bike) { double(:bike) }
    it 'defaults capacity' do
      described_class::DEFAULT_CAPACITY.times do
        subject.dock(bike)
      end
      expect { subject.dock(bike) }.to raise_error 'Docking station at capacity'
    end
    it 'has a variable capacity' do
      station = DockingStation.new(42)
      42.times { station.dock(bike) }
      expect{ station.dock(bike) }.to raise_error 'Docking station at capacity'
    end
  end

  it 'checks manual capacity insert' do
    station = DockingStation.new(42)
    expect(station.capacity).to eq 42
  end

  it 'returns docked bikes' do
    bike = double(:bike)
    allow(bike).to receive(:broken?).and_return(false)
    station = DockingStation.new
    station.dock(bike)
    expect(station.release_bike).to eq (bike)
  end

  it { is_expected.to respond_to :release_bike }

  it 'releases working bikes' do
    bike = double(:bike)
    subject.dock bike
    allow(bike).to receive(:working?).and_return(true)
    allow(bike).to receive(:broken?).and_return(false)
    bike = subject.release_bike #FIX HERE
    expect(bike).to be_working
  end

  it 'holds broken bikes' do
    broken_bike = double(:bike)
    allow(broken_bike).to receive(:report_broken).and_return(:broken)
    allow(broken_bike).to receive(:broken?).and_return(true)
    broken_bike.report_broken
    subject.dock(broken_bike)
    expect { subject.release_bike }.to raise_error 'This bike is broken'
  end

  # it { is_expected.to respond_to(:bike) }

  describe '#release_bike' do
    it 'returns error when no bike available' do
      #subject.release_bike
      expect {subject.release_bike}.to raise_error 'No bikes available'
    end
  end

  describe '#dock' do
    it 'returns error when docking station is full' do
    #subject.dock(Bike.new)
      bike = double(:bike)
      DockingStation::DEFAULT_CAPACITY.times {subject.dock double(:bike)}
      expect {subject.dock(bike)}.to raise_error 'Docking station at capacity'
    end
  end
end
