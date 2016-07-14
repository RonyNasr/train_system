require('spec_helper')

describe('train') do

  describe('#initialize') do
    it("creates a new train") do
      test_train =  Train.new({:name => "Green Line"})

      expect(test_train.name()).to(eq("Green Line"))
    end
  end

  describe('#save') do
    it ("saves a new train to database") do
      test_train =  Train.new({:name => "Green Line"})
      test_train.save()

      expect(Train.all()).to(eq([test_train]))
    end
  end

  describe ('#==') do
    it("returns true when two trains have the same ID") do
      train_1 = Train.new({:name => "Green Line"})
      train_1.save();
      train_2 = Train.new({:name => "Green Line"})
      train_2.save()

      expect(train_1.==(train_2)).to(eq(false))
    end
  end

  describe('.find') do
    it ("returns the train by id") do
      train_1 = Train.new({:name => "Green Line"})
      train_1.save();
      train_2 = Train.new({:name => "Red Line"})
      train_2.save()

      expect(Train.find(train_2.id())).to(eq(train_2))
    end
  end

  describe('#update') do
    it('find a peticular train and changes its name') do
      test_train = Train.new({:name => 'Green Line'})
      test_train.save()
      test_train.update({:name => "Red Line"})

      expect(test_train.name()).to(eq("Red Line"))
    end
  end

  describe('#delete') do
    it('find a peticular train and delete it') do
      test_train = Train.new({:name => 'Green Line'})
      test_train.save()
      test_train.delete()

      expect(Train.all()).to(eq([]))
    end
  end
end
