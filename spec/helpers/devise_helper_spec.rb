require 'spec_helper'

describe DeviseHelper do

  before do
    view.stub(:resource).and_return(User.new)
    view.stub(:resource_name).and_return(:user)
    view.stub(:devise_mapping).and_return(Devise.mappings[:user])
  end

  describe "No Error Message" do
    it { expect(helper.devise_error_messages!).to eql("") }
  end

  describe "Error Message Present" do
    it {
      view.stub(:resource).and_return(User.create)
      expect(helper.devise_error_messages!).not_to eq("")
    }
  end
end
