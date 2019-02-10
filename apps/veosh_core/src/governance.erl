-module(governance).
-include("./records.hrl").

-export([execute/4]).

execute(_Ctx, Order, Field, Args) ->
    case Field of
        <<"blockReward">> ->
          talker:talk({governance, 1}, internal);
        <<"developerReward">> ->
          talker:talk({governance, 2}, internal);
        <<"maxBlockSize">> ->
          talker:talk({governance, 3}, internal);
        <<"blockPeriod">> ->
          talker:talk({governance, 4}, internal);
        <<"timeGas">> ->
          talker:talk({governance, 5}, internal);
        <<"spaceGas">> ->
          talker:talk({governance, 6}, internal);
        <<"funLimit">> ->
          talker:talk({governance, 7}, internal);
        <<"varLimit">> ->
          talker:talk({governance, 8}, internal);
        <<"governanceChangeLimit">> ->
          talker:talk({governance, 9}, internal);
        <<"oracleInitialLiquidity">> ->
          talker:talk({governance, 10}, internal);
        <<"minimumOracleTime">> ->
          talker:talk({governance, 11}, internal);
        <<"maximumOracleTime">> ->
          talker:talk({governance, 12}, internal);
        <<"maximumQuestionSize">> ->
          talker:talk({governance, 13}, internal);
        <<"createAccountTx">> ->
          talker:talk({governance, 14}, internal);
        <<"spendTx">> ->
          talker:talk({governance, 15}, internal);
        <<"deleteAccountTx">> ->
          talker:talk({governance, 16}, internal);
        <<"newChannelTx">> ->
          talker:talk({governance, 17}, internal);
        <<"channelTeamCloseTx">> ->
          talker:talk({governance, 18}, internal);
        <<"channelSoloCloseTx">> ->
          talker:talk({governance, 19}, internal);
        <<"channelTimeoutTx">> ->
          talker:talk({governance, 20}, internal);
        <<"channelSlashTx">> ->
          talker:talk({governance, 21}, internal);
        <<"existenceProofTx">> ->
          talker:talk({governance, 22}, internal);
        <<"oracleNewTx">> ->
          talker:talk({governance, 23}, internal);
        <<"oracleBetTx">> ->
          talker:talk({governance, 24}, internal);
        <<"oracleCloseTx">> ->
          talker:talk({governance, 25}, internal);
        <<"unmatchedTx">> ->
          talker:talk({governance, 26}, internal);
        <<"oracleQuestionLiquidity">> ->
          talker:talk({governance, 28}, internal);
        <<"oracleWinningsTx">> ->
          talker:talk({governance, 27}, internal)
    end.
