require 'rails_helper'

RSpec.describe Team, :type => :model do

  let(:team) { create(:team) }

  describe "#serializable_hash" do

    context "when no additional options" do
      it "only returns id and name" do
        expect(team.to_json).to eq({id: 1, name: "team_name"}.to_json)
      end
    end

    context 'when only name is specified' do
      it 'should only return the name' do
        expect(JSON.parse(team.to_json(only: ['name']))).to eq(JSON.parse({name: team.name}.to_json))
      end
    end

  end

  describe "#search" do

    context "when no query provided" do
      it "returns activerecord model with empty where statement" do
        expect(Team.search('').all).to eq(Team.where('').all)
      end
    end

    context 'when multi worded query provided' do
      it 'appends each term in an individual where clause' do
        expect(Team.search("test terms")).to eq(Team.where("teams.name LIKE '%test%'").where("teams.name LIKE '%terms%'"))
      end
    end
  end

end
