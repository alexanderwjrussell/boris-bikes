require './lib/bike'

class DockingStation

  # attr_reader :bike #Use method #bike to check bike docked at station
  DEFAULT_CAPACITY = 20
  attr_reader :capacity

  def initialize(capacity = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    fail 'No bikes available' if empty?
    fail 'This bike is broken' if @bikes.last.broken?
    @bikes.pop
  end

 def dock(bike)
   # We need to return the bike we dock
   fail 'Docking station at capacity' if full?
   @bikes << bike
  end

  def collect_broken
    @bikes.pop
  end

  private

  attr_reader :bikes

  def full?
    @bikes.count >= @capacity
  end

  def empty?
    @bikes.empty?
  end

end
