-module(governance).
-include("./records.hrl").

-export([execute/4]).

execute(_Ctx, Order, Field, Args) ->
    case Field of
        <<"blockReward">> ->
          talker:talk({governance, block_reward}, internal);
        <<"developerReward">> ->
          talker:talk({governance, developer_reward}, internal);
        <<"maxBlockSize">> ->
          talker:talk({governance, max_block_size}, internal);
        <<"blockPeriod">> ->
          talker:talk({governance, block_period}, internal);
        <<"timeGas">> ->
          talker:talk({governance, time_gas}, internal);
        <<"spaceGas">> ->
          talker:talk({governance, space_gas}, internal);
        <<"funLimit">> ->
          talker:talk({governance, fun_limit}, internal);
        <<"varLimit">> ->
          talker:talk({governance, var_limit}, internal);
        <<"governanceChangeLimit">> ->
          talker:talk({governance, governance_change_limit}, internal);
        <<"oracleInitialLiquidity">> ->
          talker:talk({governance, oracle_initial_liquidity}, internal);
        <<"minimumOracleTime">> ->
          talker:talk({governance, minimum_oracle_time}, internal);
        <<"maximumOracleTime">> ->
          talker:talk({governance, maximum_oracle_time}, internal);
        <<"maximumQuestionSize">> ->
          talker:talk({governance, maximum_question_size}, internal);
        <<"createAccountTx">> ->
          talker:talk({governance, create_acc_tx}, internal);
        <<"spendTx">> ->
          talker:talk({governance, spend}, internal);
        <<"deleteAccountTx">> ->
          talker:talk({governance, delete_acc_tx}, internal);
        <<"newChannelTx">> ->
          talker:talk({governance, nc}, internal);
        <<"channelTeamCloseTx">> ->
          talker:talk({governance, ctc}, internal);
        <<"channelSoloCloseTx">> ->
          talker:talk({governance, csc}, internal);
        <<"channelTimeoutTx">> ->
          talker:talk({governance, timeout}, internal);
        <<"channelSlashTx">> ->
          talker:talk({governance, cs}, internal);
        <<"existenceProofTx">> ->
          talker:talk({governance, ex}, internal);
        <<"oracleNewTx">> ->
          talker:talk({governance, oracle_new}, internal);
        <<"oracleBetTx">> ->
          talker:talk({governance, oracle_bet}, internal);
        <<"oracleCloseTx">> ->
          talker:talk({governance, oracle_close}, internal);
        <<"unmatchedTx">> ->
          talker:talk({governance, unmatched}, internal);
        <<"oracleQuestionLiquidity">> ->
          talker:talk({governance, oracle_question_liquidity}, internal);
        <<"oracleWinningsTx">> ->
          talker:talk({governance, oracle_winnings}, internal)
    end.
