require 'spec_helper'

describe Api::ActivitiesController do
  context 'allowed params' do
    let(:allowed_params) { { name: 'activity name' } }
    let(:all_params)     { { foo: 'bar', activity: { invalid: 'value' }.merge(allowed_params) } }
    let(:request_params) {
      ActionController::Parameters.new(all_params)
    }
    let(:permitted_params) {
      described_class::ActivityParams.permit(request_params)
    }

    it { expect(permitted_params).to eq(allowed_params.with_indifferent_access) }
  end
end
