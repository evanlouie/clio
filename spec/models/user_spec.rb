require 'spec_helper'

describe User do

  let(:user) { create(:user) }
  let(:team) { create(:team) }
  describe "#status=" do
    before do
      user.status = status
    end

    context "when given an accepted value" do
      let(:status) { :in }
      it "writes the enumerated value in the database" do
        expect(user.send(:read_attribute, :status)).to eql User::STATUSES[status]
      end
    end

    context "when given an unacceptable value" do
      let(:status) { :bad_status }
      it "writes nil in the database" do
        expect(user.send(:read_attribute, :status)).to be_nil
      end
    end

  end

  describe 'vaidations' do
    context 'valid team_id' do
      it 'updates successfully' do
        user.team_id = team.id
        user.save
        expect(user.errors[:team_id].size).to be == 0 
      end
    end
    context 'invalid team_id' do
      it 'adds to errors' do
        user.team_id = 123
        user.save
        expect(user.errors[:team_id].size).to be > 0
      end
    end
  end

  describe "#current_sign_in_ip= and #last_sign_in_ip=" do
    context "provided with valid ip string" do
      it 'converts the string to an int and returns the value of the writeback' do
        expect(user.current_sign_in_ip= '192.168.0.1').to be == "192.168.0.1"
      end
    end
    context 'provided with invalid ip string' do
      it 'converts string to nil and returns value of writeback' do
        expect(user.current_sign_in_ip= '123').to be == '123'
      end
    end
  end

  describe 'current_sign_in_ip and last_sign_in_ip' do
    context 'user has an ip stored' do
      it 'returns the ip as as string' do
        user.current_sign_in_ip='192.168.0.1'
        expect(user.current_sign_in_ip).to be == '192.168.0.1'
      end
    end
  end

  describe "#full_name" do

    context "when valid first name and last name" do
      it "returns the combined full name" do
        expect(user.full_name).to be == 'Test Person'
      end
    end
  end

  describe "#search" do
    context "when no query provided" do
      it "returns empty where clause" do
        expect(User.search("")).to be == User
      end
    end

    context "when multi worded query provided" do
      it 'appends each term in a separate where clause' do
        expect(User.search("sample search")).to be == User.where('users.first_name LIKE ? OR users.last_name LIKE ? OR users.email LIKE ?',"%sample%","%sample%","%sample%").where('users.first_name LIKE ? OR users.last_name LIKE ? OR users.email LIKE ?', '%search%', '%search%', '%search%')
      end
    end
  end

end
