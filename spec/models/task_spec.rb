require 'rails_helper'

RSpec.describe Task, type: :model do
  
  describe '#toggle_complete!' do
    it 'should switch complete to false if it began as true' do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it 'should switch complete to true if it began as false' do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do
    it 'should switch favorite to false if it began as true' do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it 'should switch favorite to true if it began as false' do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe '#overdue?' do
    it 'should return true if the current time is past the deadline time' do
      task = Task.create(deadline: Time.now - 1.hour)
      expect(task.overdue?).to eq(true)
    end

    it 'should return false if the current time is before the deadline time' do
      task = Task.create(deadline: Time.now + 1.hour)
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do
    it 'should add 1 to the priority of a task' do
      task = Task.create(priority: 1)
      task.increment_priority!
      expect(task.priority).to eq(2)
    end

    it 'should not add to the priority of a task if priority starts at 10' do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrement_priority!' do
    it 'should subtract 1 from the priority of a task' do
      task = Task.create(priority: 2)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end

    it 'should not subtract from the priority if the priority is at or below 1' do
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    it 'should add one hour to the deadline' do
      time = Time.now
      task = Task.create(deadline: time)
      task.snooze_hour!
      expect(task.deadline).to eq(time + 1.hour)
    end
  end

end
