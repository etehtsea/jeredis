require 'jeredis/ext'

module Jeredis
  class Client
    java_import Java::RedisClientsJedis::Jedis

    def initialize(jedis_client = nil)
      @jedis_client = jedis_client || Jedis.new
    end

    # TODO: check
    def close
      @jedis_client.close
    end

    # FIXME: Implement
    def pipelined
      @jedis_client.pipelined
    end

    # Hash commands
    def hget(key, field)
      @jedis_client.hget(key.to_s, field.to_s)
    end

    def hset(key, field, value)
      @jedis_client.hset(key.to_s, field.to_s, value.to_s)
    end

    def hgetall(key)
      @jedis_client.hget_all(key.to_s)
    end

    def hdel
    end

    def hexists
    end

    def hincrby
    end

    def hincrbyfloat
    end

    def hkeys
    end

    def hlen
    end

    def hmget
    end

    def hmset
    end

    def hsetnxhstrlen
    end

    def hvals
    end

    def hscan
    end
  end
end
