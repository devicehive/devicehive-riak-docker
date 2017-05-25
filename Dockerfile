FROM basho/riak-ts:1.4.0
MAINTAINER devicehive

RUN mkdir -p /etc/riak/dh-mr/src /etc/riak/dh-mr/ebin \
    && curl -o /etc/riak/dh-mr/src/dhmr.erl https://raw.githubusercontent.com/devicehive/devicehive-java-server/master/devicehive-riak-dao/src/main/resources/map-reduce/dhmr.erl \
    && /usr/lib/riak/$(ls /usr/lib/riak/ | grep erts)/bin/erlc -o /etc/riak/dh-mr/ebin /etc/riak/dh-mr/src/*.erl \
    && echo '[{riak_kv, [{add_paths, ["/etc/riak/dh-mr/ebin"]}]}].' > /etc/riak/advanced.config

# Following will create "counter" bucket type on start
RUN echo "counter" > /etc/riak/schemas/counters.dt
