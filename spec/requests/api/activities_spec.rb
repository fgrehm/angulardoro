require 'spec_helper'

describe "Activities API" do
  it 'sends a list of sorted activities' do
    Fabricate.times(9, :activity)
    highest = Fabricate(:activity, priority: 9999999)

    get '/api/activities'

    expect(response.status).to eq(200)
    expect(json['activities'].length).to eq(10)
    expect(json['activities'][0]['id']).to eq(highest.id)
  end

  it 'creates activities' do
    attrs = Fabricate.to_params(:activity)

    expect {
      post '/api/activities', activity: attrs
    }.to change {Activity.count}.by(1)

    expect(response.status).to eq(201) # Created
    expect(json['activity']).to include(attrs)
  end

  it 'updates activities' do
    activity = Fabricate(:activity)
    attrs    = { name: 'new' }

    expect {
      put "/api/activities/#{activity.id}", activity: attrs
    }.to_not change {Activity.count}

    expect(activity.reload.name).to eq('new')
    expect(response.status).to eq(204)
  end

  it 'removes activities' do
    activity = Fabricate(:activity)

    expect {
      delete "/api/activities/#{activity.id}"
    }.to change {Activity.count}.by(-1)

    expect(response.status).to eq(204)
  end

  it 'sorts activities' do
    # At this point, high / low priorities are the other way aroudn
    high_priority = Fabricate(:activity, priority: 0)
    low_priority  = Fabricate(:activity, priority: 1)

    expect {
      put "/api/activities/sort", activities: [high_priority.id, low_priority.id]
    }.to_not change {Activity.count}

    expect(high_priority.reload.priority).to eq(1)
    expect(low_priority.reload.priority).to eq(0)
    expect(response.status).to eq(204)
  end
end
