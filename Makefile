help:
	@cat Makefile

setup:
	stack setup

build:
	stack build

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

s: setup
b: build
d: deploy
