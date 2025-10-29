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

    it "should call a method if you pass a symbol as interactor" do
      allow(TestOrganizer).to receive(:organized).and_return(
        [:interactor1,
         { class: :interactor2, if: :condition_true },
         { class: :interactor3 }]
      )
      calls = 0
      allow_any_instance_of(TestOrganizer).to receive(:interactor1) { calls += 1 }
      allow_any_instance_of(TestOrganizer).to receive(:interactor2) { calls += 1 }
      allow_any_instance_of(TestOrganizer).to receive(:interactor3) { calls += 1 }
      expect { TestOrganizer.call }.to change { calls }.by(3)
    end
  end
end
