-module(root_query).
-include("./records.hrl").

-export([execute/4]).

execute(_, _, Field, Args) ->
  case Field of
    <<"account">> ->
      #{ <<"pubkey">> := Pubkey } = Args,
      talker:talk({account, Pubkey}, external);
    <<"header">> ->
      #{ <<"height">> := Height } = Args,
      talker:talk({header, Height}, external);
    <<"block">> ->
      #{ <<"height">> := Height } = Args,
      talker:talk({block, Height}, external);
    <<"height">> ->
      talker:talk({height}, external);
    <<"governance">> ->
      {ok, #governance{}};
    <<"oracles">> ->
      {_, Oracles } = talker:talk({oracles}, internal),
      SortedOracles = lists:sort(fun({_, X}, {_, Y}) -> X#oracle.starts > Y#oracle.starts end, Oracles),
      {ok, [{ok, M} || M <- SortedOracles]};
    <<"oracle">> ->
      #{ <<"id">> := Id } = Args,
      talker:talk({oracle, Id}, internal)

  end.
