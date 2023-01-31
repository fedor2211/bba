require 'rails_helper'

RSpec.describe EventPolicy do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:event) { create(:event, user: user1) }

  subject { EventPolicy }

  permissions :create? do
    it { is_expected.to permit(user1) }
    it { is_expected.not_to permit(nil) }
  end

  permissions :new? do
    it { is_expected.to permit(user1) }
    it { is_expected.not_to permit(nil) }
  end

  permissions :show? do
    it { is_expected.to permit(user1, event) }
    it { is_expected.to permit(user2, event) }
    it { is_expected.to permit(nil, event) }
  end

  permissions :update? do
    it { is_expected.to permit(user1, event) }
    it { is_expected.not_to permit(user2, event) }
    it { is_expected.not_to permit(nil, event) }
  end

  permissions :edit? do
    it { is_expected.to permit(user1, event) }
    it { is_expected.not_to permit(user2, event) }
    it { is_expected.not_to permit(nil, event) }
  end

  permissions :destroy? do
    it { is_expected.to permit(user1, event) }
    it { is_expected.not_to permit(user2, event) }
    it { is_expected.not_to permit(nil, event) }
  end

  describe '.scope' do
    let(:events) { create_list(:event, 10, user: user1) }

    context 'when user not logged in' do
      it 'contains all events' do
        expect(Pundit.policy_scope(nil, Event)).to match_array(Event.all)
      end
    end

    context 'when creator logged in' do
      it 'contains all events' do
        expect(Pundit.policy_scope(user1, Event)).to match_array(Event.all)
      end
    end

    context 'when another user logged in' do
      it 'contains all events' do
        expect(Pundit.policy_scope(user2, Event)).to match_array(Event.all)
      end
    end
  end
end
