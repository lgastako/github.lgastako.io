EXE=lgastako

help:
	@cat Makefile

clean:
	stack exec $(EXE) clean

setup:
	stack setup

build:
	stack build

rebuild:
	stack exec $(EXE) rebuild

full-build: build rebuild

deploy:
	git checkout develop
	stack exec lgastako clean
	stack exec lgastako build
	git fetch --all
	git co master
	rsync -a --filter='P _site/'      \
			 --filter='P _cache/'     \
			 --filter='P .git/'       \
			 --filter='P .gitignore'  \
			 --filter='P .stack-work' \
			 --delete-excluded        \
			 _site/ .
	git add -A
	git commit -m "Publish."
	git push origin master:master
	git checkout develop

s: setup
b: build
d: deploy
