REBAR=./rebar3

.PHONY: compile shell-schema release dialyzer publish documentation test

compile:
	$(REBAR) compile

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

DOC_SOURCES = $(wildcard doc/*.asciidoc)
IMAGE_SOURCES = $(wildcard doc/images/*)
doc/book.html: $(DOC_SOURCES)
	asciidoctor doc/book.asciidoc

index.html: doc/book.html
	cp doc/book.html index.html

documentation: doc/book.html
publish: index.html
	touch doc/book.asciidoc # Bump the last-updated-label
	cp -r $(IMAGE_SOURCES) images
