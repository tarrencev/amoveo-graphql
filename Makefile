REBAR=./rebar3

CORE = rel/veosh/bin/veosh

.PHONY: build go compile shell-schema release dialyzer publish test

compile:
	$(REBAR) compile

run:
	@./_build/default/rel/veosh/bin/veosh console

go:
	make compile
	make release
	make run

## Rebar3 advertises that its shell command boots the system with a
## changed path:
##
## Start a shell with project and deps preloaded similar to
## 'erl -pa ebin -pa deps/*/ebin'.
##
## It doesn't. It also starts the applications. We don't want
## the applications started, hence this little blurb:
shell-schema:
	erl -pa `$(REBAR) path` -name veosh@127.0.0.1

release:
	$(REBAR) release

dialyzer:
	$(REBAR) dialyzer

test:
	$(REBAR) ct
