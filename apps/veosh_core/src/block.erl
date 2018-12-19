-module(block).
-include("./records.hrl").

-export([execute/4]).

estimate_future_block_time(Height) ->
    {_, Top} = talker:talk({height}, {{127,0,0,1}, 8080}),
    {_, TopBlock} = talker:talk({block, Height}, {{127,0,0,1}, 8080}),
    {_, Period} = talker:talk({governance, block_period}, {{127,0,0,1}, 8081}),
    (Height - Top) * Period + TopBlock#block.time.

execute(_Ctx, Block, Field, Args) ->
    case Field of
        <<"height">> ->
          {ok, Block#block.height};
        <<"prevHash">> ->
          {ok, base64:encode(Block#block.prev_hash)};
        <<"treesHash">> ->
          {ok, base64:encode(Block#block.trees_hash)};
        <<"time">> ->
          Time = Block#block.time,
          case Time of
            undefined -> {ok, estimate_future_block_time(Block#block.height) + constants:start_time()};
            _ -> {ok, Block#block.time + constants:start_time()}
          end;
        <<"difficulty">> ->
          {ok, Block#block.difficulty};
        <<"period">> ->
          {ok, Block#block.period};
        <<"version">> ->
          {ok, Block#block.version};
        <<"nonce">> ->
          {ok, Block#block.nonce};
        <<"marketCap">> ->
          {ok, Block#block.market_cap};
        <<"channelsVeo">> ->
          {ok, Block#block.channels_veo};
        <<"liveChannels">> ->
          {ok, Block#block.live_channels};
        <<"manyAccounts">> ->
          {ok, Block#block.many_accounts};
        <<"manyOracles">> ->
          {ok, Block#block.many_accounts};
        <<"liveOracles">> ->
          {ok, Block#block.many_accounts};
        <<"transactions">> ->
          {ok, [{ok, M} || M <- Block#block.txs]}
    end.
