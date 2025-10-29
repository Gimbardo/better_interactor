# frozen_string_literal: true

RSpec.describe Interactor do

  describe "call" do

    it "should be callable" do
      TestInteractor.call
    end
  end

  describe "default_condition_name" do
    it "should return an underscore version of your class name" do
      expect(TestInteractor.default_condition_name).to eq("can_test_interactor?")
      allow(TestInteractor).to receive(:name).and_return("Folder::TestInteractor")
      expect(TestInteractor.default_condition_name).to eq("can_folder_test_interactor?")
    end
  end
end
