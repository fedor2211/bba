require 'rails_helper'

RSpec.describe EventPolicy do
  let(:user1) { build_stubbed(:user) }
  let(:user2) { build_stubbed(:user) }
  let(:event) { build_stubbed(:event, user: user1) }

  subject { EventPolicy }

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
end
