require 'rails_helper'

describe PagePolicy do
  subject { PagePolicy.new(user, page) }

  let(:page) { FactoryGirl.create(:page) }

  context "for a visitor" do
    let(:user) { nil }

    it { should permit(:show) }
    it { should_not permit(:create) }
    it { should_not permit(:new) }
    it { should_not permit(:update) }
    it { should_not permit(:edit) }
    it { should_not permit(:destroy) }
  end

  context "for an administrator" do
    let(:user) { FactoryGirl.create(:user, administrator: true) }

    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should permit(:destroy) }
  end
end
