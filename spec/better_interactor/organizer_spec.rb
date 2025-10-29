# frozen_string_literal: true

RSpec.describe Interactor::Organizer do
  describe "call" do
    it "should call! the interactor if no condition is passed" do
      allow(TestOrganizer).to receive(:organized).and_return([TestInteractor])
      expect(TestInteractor).to receive(:call!)
      TestOrganizer.call
    end

    it "should call! the interactor if a condition is passed, and that condition returns true" do
      allow(TestOrganizer).to receive(:organized).and_return([{class: TestInteractor, if: :condition_true}])
      expect(TestInteractor).to receive(:call!)
      TestOrganizer.call
    end

    it "shouldn't call! the interactor if a condition is passed, and that condition returns false" do
      allow(TestOrganizer).to receive(:organized).and_return([{class: TestInteractor, if: :condition_false}])
      expect(TestInteractor).not_to receive(:call!)
      TestOrganizer.call
    end

    it "should call! the interactor if a default condition exists, and it returns true" do
      allow(TestOrganizer).to receive(:organized).and_return([TestInteractor])
      allow(TestOrganizer).to receive(TestInteractor.default_condition_name.to_sym).and_return(true)
      expect(TestInteractor).to receive(:call!)
      TestOrganizer.call
    end

    it "shouldn't call! the interactor if a default condition exists, and it returns false" do
      allow(TestOrganizer).to receive(:organized).and_return([TestInteractor])
      allow_any_instance_of(TestOrganizer).to receive(TestInteractor.default_condition_name.to_sym).and_return(false)
      expect(TestInteractor).not_to receive(:call!)
      TestOrganizer.call
    end
  end
end
