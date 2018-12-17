-module(type).
-include("./records.hrl").

-export([execute/1]).

%% tag::resolveType[]
execute(#acc{}) -> {ok, 'Account'};
execute(#block{}) -> {ok, 'Block'};
execute(#header{}) -> {ok, 'Header'};
execute(#oracle{}) -> {ok, 'Oracle'};
execute(#orderproof{}) -> {ok, 'Order'};
execute(#governance{}) -> {ok, 'Governance'};
execute(#transaction_hash{}) -> {ok, 'SignedTransactionPayload'};
execute(_Otherwise) -> {error, unknown_type}.
%% end::resolveType[]
