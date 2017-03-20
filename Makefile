

all:
	hexo clean
	hexo generate
	hexo deploy

deploy:
	hexo deploy

generate:
	hexo generate

install:
	sh _create.sh
	cp -f _config.yml.IN _config.yml
	cp -f themes.next._config.yml.IN themes/next/_config.yml
