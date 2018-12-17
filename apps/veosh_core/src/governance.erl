-module(governance).
-include("./records.hrl").

-export([execute/4]).

execute(_Ctx, Order, Field, Args) ->
    case Field of
        <<"blockReward">> ->
          {ok, api:governance(block_reward)};
        <<"developerReward">> ->
          {ok, api:governance(developer_reward)};
        <<"maxBlockSize">> ->
          {ok, api:governance(max_block_size)};
        <<"blockPeriod">> ->
          {ok, api:governance(block_period)};
        <<"timeGas">> ->
          {ok, api:governance(time_gas)};
        <<"spaceGas">> ->
          {ok, api:governance(space_gas)};
        <<"funLimit">> ->
          {ok, api:governance(fun_limit)};
        <<"varLimit">> ->
          {ok, api:governance(var_limit)};
        <<"governanceChangeLimit">> ->
          {ok, api:governance(governance_change_limit)};
        <<"oracleInitialLiquidity">> ->
          {ok, api:governance(oracle_initial_liquidity)};
        <<"minimumOracleTime">> ->
          {ok, api:governance(minimum_oracle_time)};
        <<"maximumOracleTime">> ->
          {ok, api:governance(maximum_oracle_time)};
        <<"maximumQuestionSize">> ->
          {ok, api:governance(maximum_question_size)};
        <<"createAccountTx">> ->
          {ok, api:governance(create_acc_tx)};
        <<"spendTx">> ->
          {ok, api:governance(spend)};
        <<"deleteAccountTx">> ->
          {ok, api:governance(delete_acc_tx)};
        <<"newChannelTx">> ->
          {ok, api:governance(nc)};
        <<"channelTeamCloseTx">> ->
          {ok, api:governance(ctc)};
        <<"channelSoloCloseTx">> ->
          {ok, api:governance(csc)};
        <<"channelTimeoutTx">> ->
          {ok, api:governance(timeout)};
        <<"channelSlashTx">> ->
          {ok, api:governance(cs)};
        <<"existenceProofTx">> ->
          {ok, api:governance(ex)};
        <<"oracleNewTx">> ->
          {ok, api:governance(oracle_new)};
        <<"oracleBetTx">> ->
          {ok, api:governance(oracle_bet)};
        <<"oracleCloseTx">> ->
          {ok, api:governance(oracle_close)};
        <<"unmatchedTx">> ->
          {ok, api:governance(unmatched)};
        <<"oracleQuestionLiquidity">> ->
          {ok, api:governance(oracle_question_liquidity)};
        <<"oracleWinningsTx">> ->
          {ok, api:governance(oracle_winnings)}
    end.
