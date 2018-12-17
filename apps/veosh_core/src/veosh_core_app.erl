%%%-------------------------------------------------------------------
%% @doc veosh_core public API
%% @end
%%%-------------------------------------------------------------------

-module(veosh_core_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    {ok, Pid} = sup:start_link(),
    ok = load_schema(),
    {ok, Pid}.

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

load_schema() ->
    {ok, SchemaFile} = application:get_env(amoveo_http, schema_file),
    PrivDir = code:priv_dir(amoveo_http),
    {ok, SchemaData} = file:read_file(
                         filename:join(PrivDir, SchemaFile)),
    Mapping = #{
      enums => #{ 'TransactionType' => enum,
                  'GovernanceOracleVariable' => enum,
                  'OracleType' => enum,
                   default   => enum },
       interfaces => #{ default => type },
       unions => #{ default => unions },
       objects => #{
         'Account' => account,
         'Block' => block,
         'Header' => header,
         'CoinbaseTransaction' => coinbase_transaction,
         'CreateAccountTransaction' => create_account_transaction,
         'DeleteAccountTransaction' => delete_account_transaction,
         'Governance' => governance,
         'Oracle' => oracle,
         'Order' => order,
         'SpendTransaction' => spend_transaction,
         'SignedTransactionPayload' => transaction_hash,
         'Query' => query,
         'Mutation' => mutation,
         default => object }
     },
    ok = graphql:load_schema(Mapping, SchemaData),
    Root = {root,
            #{ query => 'Query',
               mutation => 'Mutation'
             }},
    ok = graphql:insert_schema_definition(Root),
    ok = graphql:validate_schema(),
    ok.
