# frozen_string_literal: true

shared_examples 'responds with 401' do
  it 'responds with 401' do
    subject
    expect(response.status).to eq(401)
    expect(response.body).to eq({ error: 'unauthorized' }.to_json)
  end
end

shared_examples 'responds with 422' do
  it 'responds with 422' do
    subject
    expect(response.status).to eq(422)
    expect(response.body).to eq({ error: 'unprocessable' }.to_json)
  end
end
