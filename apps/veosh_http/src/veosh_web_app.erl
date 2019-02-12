%%%-------------------------------------------------------------------
%% @doc veosh_web public API
%% @end
%%%-------------------------------------------------------------------

-module(veosh_web_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    %% tag::dispatcher[]
    Dispatch =
        cowboy_router:compile(
          [{'_',
            [{"/", veosh_web_graphql_handler,
              {priv_file, veosh_web, "site/index.html"}}
            ]}]),
    %% end::dispatcher[]
    {ok, Port} = application:get_env(veosh_web, http_port),
    error_logger:info_msg("Starting HTTP listener on port ~p", [Port]),
    {ok, Pid} = veosh_web_sup:start_link(),
    cowboy:start_clear(veosh_http,
                      [{port, Port}],
                      #{
                        middlewares => [cowboy_router, veosh_web_cors_middleware, cowboy_handler],
                        env => #{dispatch => Dispatch},
                        stream_handlers => [cowboy_compress_h, cowboy_stream_h],
                       %% Bump the default limit of 8000 to 65536 to allow us to submit
                       %% slightly larger, human readable, query documents. The limit of
                       %% 65536 is chosen to allow us to have 8 times bigger documents
                       %% than the default where we hit the limit of 8000. If you are
                       %% hitting the bumped limit you should probably consider splitting
                       %% up your query document into two.
                       %%
                       %% Caveat: If you are testing on localhost you might not see the
                       %% max limit have any effect since the socket might make the entire
                       %% HTTP request available when cowboy does a gen_tcp:read(Socket, 0)
                       %% and will ignore the limit.
                       max_request_line_length => 65536,

                       %% Bump the default limit of 4096 on Header lengths to 16384. The
                       %% problem is we will eventually get a very large document as a
                       %% referrer from GraphiQL and this will break the server side as it
                       %% has to process through that header
                       max_header_value_length => 16384
                       }
                      ),
    {ok, Pid}.

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
