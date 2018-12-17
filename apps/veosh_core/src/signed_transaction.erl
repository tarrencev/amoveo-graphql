-module(signed_transaction).
-include("./records.hrl").

-export([create/2]).

create(_Ctx, #{ <<"transaction">> := Transaction,
                <<"sig">> := Sig }) ->
    Tx = #signed{ data = Transaction, sig = Sig },
    tx_pool_feeder:absorb([Tx]),
    TxnHash = #transaction_hash{ hash = hash:doit(Tx) },
    {ok, TxnHash}.
