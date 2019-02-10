-module(oracle).
-include("./records.hrl").

-export([execute/4]).

orders(OID) ->
  Orders = talker:talk({orders, OID}, internal),
  P = lists:map(fun(Order) ->
    {Root, Data, Path} = Order,
    #orderproof{root = Root,
       path = Path,
       value = Data}
  end, Orders),

  {P2, _} = lists:split(length(P) - 1, P), % remove headers
  P2.

execute(_Ctx, {Message, Oracle}, Field, Args) ->
    case Field of
        <<"id">> ->
          {ok, base64:encode(Oracle#oracle.id)};
        <<"result">> ->
          {ok, Oracle#oracle.result};
        <<"question">> ->
          io:format("Message: ~p~n", [Message]),
          {ok, Message};
        <<"questionHash">> ->
          {ok, base64:encode(Oracle#oracle.question)};
        <<"starts">> ->
          Starts = Oracle#oracle.starts,
          {ok, Height} = talker:talk({height}, external),
          case Height < Starts of
            true ->
              io:format("Starts1: ~p~n", [Starts]),
              {ok, #block{height = Starts}}; % block is in the future, return mock block
            false ->
              io:format("Starts2: ~p~n", [Starts]),
              {_, Block} = talker:talk({block, Starts}, external),
              io:format("BlockH: ~p~n", [Block#block.height]),
              {ok, Block}
          end;
        <<"type">> ->
          case Oracle#oracle.type of
            0 ->
              {ok, 'EMPTY'};
            1 ->
              {ok, 'TRUE'};
            2 ->
              {ok, 'FALSE'};
            3 ->
              {ok, 'BAD_QUESTION'}
          end;
        <<"orders">> ->
          Orders = orders(Oracle#oracle.id),
          {ok, [{ok, M} || M <- Orders]};
        <<"unmatched">> ->
          Orders = orders(Oracle#oracle.id),
          Amounts = [R#orderproof.value#orders.amount || R <- Orders],
          {ok, lists:sum(Amounts)};
        <<"creator">> ->
          {ok, base64:encode(Oracle#oracle.creator)};
        <<"ends">> ->
          Ends = Oracle#oracle.done_timer,
          {ok, Height} = talker:talk({height}, external),
          case Height < Ends of
            true -> {ok, #block{height = Ends}}; % block is in the future, return mock block
            false -> talker:talk({block, Ends}, external)
          end;
        <<"governance">> ->
          case Oracle#oracle.governance of
            0 ->
              {ok, 'NONE'};
            1 ->
              {ok, 'BLOCK_REWARD'};
            2 ->
              {ok, 'DEVELOPER_REWARD'};
            3 ->
              {ok, 'MAX_BLOCK_SIZE'};
            4 ->
              {ok, 'BLOCK_PERIOD'};
            5 ->
              {ok, 'TIME_GAS'};
            6 ->
              {ok, 'SPACE_GAS'};
            7 ->
              {ok, 'FUN_LIMIT'};
            8 ->
              {ok, 'VAR_LIMIT'};
            9 ->
              {ok, 'GOVERNANCE_CHANGE_LIMIT'};
            10 ->
              {ok, 'ORACLE_INITIAL_LIQUIDITY'};
            11 ->
              {ok, 'MINIMUM_ORACLE_TIME'};
            12 ->
              {ok, 'MAXIMUM_ORACLE_TIME'};
            13 ->
              {ok, 'MAXIMUM_QUESTION_SIZE'};
            14 ->
              {ok, 'CREATE_ACC_TX'};
            15 ->
              {ok, 'SPEND'};
            16 ->
              {ok, 'DELETE_ACC_TX'};
            17 ->
              {ok, 'NC'};
            18 ->
              {ok, 'CTC'};
            19 ->
              {ok, 'CSC'};
            20 ->
              {ok, 'TIMEOUT'};
            21 ->
              {ok, 'CS'};
            22 ->
              {ok, 'EX'};
            23 ->
              {ok, 'ORACLE_NEW'};
            24 ->
              {ok, 'ORACLE_BET'};
            25 ->
              {ok, 'ORACLE_CLOSE'};
            26 ->
              {ok, 'UNMATCHED'};
            27 ->
              {ok, 'ORACLE_WINNINGS'};
            28 ->
              {ok, 'ORACLE_QUESTION_LIQUIDITY'}
          end;
        <<"governanceAmount">> ->
          {ok, Oracle#oracle.governance_amount}
    end.
