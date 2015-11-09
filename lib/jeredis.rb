require 'java'
require 'ext/jedis'
require 'ext/commons-pool2'

module Jeredis
  class Pool
    java_import Java::RedisClientsJedis::JedisPool
    java_import Java::RedisClientsJedis::JedisPoolConfig

    attr_reader :pool

    # Initialize Jedis pool
    # @param [Hash] opts Connection options
    #
    # @option options [String] :host ("localhost") Hostname or IP address.
    # @option options [Integer] :port (6379) Redis server port.
    # @option options [Integer] :timeout (5000) Connection timeout in ms.
    # @option options [String] :password Redis server password.
    # @option options [Integer] :db Redis database number.
    # @option options [Integer] :min_idle Min idle threads in a pool.
    # @option options [Integer] :max_idle Max idle threads in a pool.
    # @option options [Integer] :max_total Max total active threads.
    def initialize(options = {})
      opts = options.dup
      host = opts.delete(:host) || 'localhost'
      port = opts.delete(:port) || 6379
      timeout = opts.delete(:timeout) || 5000
      password = opts.delete(:password)
      db = opts.delete(:db) || 0

      config = JedisPoolConfig.new
      config.minIdle = opts.fetch(:min_idle) if opts[:min_idle]
      config.maxIdle = opts.fetch(:max_idle) if opts[:max_idle]
      config.maxTotal = opts.fetch(:max_total) if opts[:max_total]
      config.block_when_exhausted = false
      config.max_wait_millis = timeout
      config.jmx_enabled = true

      @pool = JedisPool.new(config, host, port, timeout, password, db)
    end

    def with
      conn = @pool.resource
      yield conn
    ensure
      conn.close if conn
    end

    def pipelined
      with do |j|
        pipeline = j.pipelined
        response = yield pipeline
        pipeline.sync_and_return_all.to_a
      end
    end
  end
end
