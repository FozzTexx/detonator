IMAGE=detonator
VERSION=1.0
SRCFILES=$(shell git ls-tree --full-tree -r --name-only --full-name HEAD | grep '^src/')
HTMLFILES=$(shell git ls-tree --full-tree -r --name-only --full-name HEAD | grep '^html/')
CONFFILES=$(shell git ls-tree --full-tree -r --name-only --full-name HEAD | grep '^conf/')

all:: webconsole-server database-server

webconsole-server: Dockerfile-webconsole
	docker build --file Dockerfile-webconsole \
	  --rm -t $(IMAGE)-webconsole:$(VERSION) -t $(IMAGE)-webconsole:latest .

database-server: Dockerfile-database detonator.sql
	docker build --file Dockerfile-database \
	  --rm -t $(IMAGE)-database:$(VERSION) -t $(IMAGE)-database:latest .

