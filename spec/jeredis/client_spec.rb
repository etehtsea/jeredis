require 'jeredis/client'

RSpec.describe Jeredis::Client do
  let(:redis) do
    Redis.new
  end

  describe '#hget' do
    it 'existing field' do
      redis.hset(:jeredis, :field, 10)

      expect(subject.hget(:jeredis, :field)).to eq('10')
    end

    it 'key no present' do
      expect(subject.hget(:jeredis, :nofield)).to be_nil
    end
  end

  describe '#hset' do
    it 'new field' do
      expect(subject.hset(:jeredis, :new_field, 10)).to eq(1)
      expect(redis.hget(:jeredis, :new_field)).to eq('10')
    end

    it 'existing field' do
      redis.hset(:jeredis, :existing_field, 10)

      expect(subject.hset(:jeredis, :existing_field, 20)).to eq(0)
      expect(redis.hget(:jeredis, :existing_field)).to eq('20')
    end
  end

  describe '#hgetall' do
    it do
      redis.hset(:jeredis, :f1, 'Hello')
      redis.hset(:jeredis, :f2, 'World')

      expect(subject.hgetall(:jeredis)).to eq('f1' => 'Hello', 'f2' => 'World')
    end
  end
end
