require 'rails_helper'

RSpec.describe Team, :type => :model do

  let(:team) { create(:team) }

  describe "#serializable_hash" do

    context "when no additional options" do
      it "only returns id and name" do
        team.to_json.should == {id: 1, name: "team_name"}.to_json
      end
    end

    context 'when only name is specified' do
      it 'should only return the name' do
        JSON.parse(team.to_json(only: ['name'])).should == JSON.parse({name: team.name}.to_json)
      end
    end

  end

  describe "#search" do

    context "when no query provided" do
      it "returns activerecord model with empty where statement" do
        Team.search('').all.should == Team.where('').all
      end
    end

    context 'when multi worded query provided' do
      it 'appends each term in an individual where clause' do
        Team.search("test terms").should == Team.where("teams.name LIKE '%test%'").where("teams.name LIKE '%terms%'")
      end
    end
  end

end
