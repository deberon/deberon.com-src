.PHONY: clean build deploy

WORKDIR := $(shell mktemp -d)

clean:
	rm -rf public/*

build: clean
	hugo

deploy: build
	cd $(WORKDIR) && echo "www.deberon.com" > CNAME && git init && git remote add origin git@github.com:deberon/deberon.github.io.git
	cp -r public/* $(WORKDIR)
	cd $(WORKDIR) && git add . && git commit -m "Auto-deploying." && git push --force origin master
