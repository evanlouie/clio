require 'spec_helper'

describe ApplicationHelper do
  let(:user) { create(:user) }
  describe '#name_with_status' do

  end

  describe '#user_status_badge' do

    context "status is in" do
      it 'returns span with in className' do
        user.status = :in
        user_status_badge(user).should == "<span class='status-badge label label-success label-as-badge'>#{user.status.capitalize}</span>".html_safe
      end
    end
    context 'status is not in' do
      it 'returns span with out className' do
        user.status = :out
        user_status_badge(user).should == "<span class='status-badge label label-default label-as-badge'>#{user.status.capitalize}</span>".html_safe
      end
    end
  end
end
