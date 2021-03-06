RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

# use those 3 commands in Linux
docker-start:
	sudo systemctl start docker.service

docker-stop:
	sudo systemctl stop docker.service

docker-restart:
	sudo systemctl restart docker.service

################################################
# Docker ops

docker-build:
	docker-compose build

docker-upd:
	docker-compose up -d

docker-up:
	docker-compose up

docker-down:
	docker-compose down

#docker-chown:
#	cd sequra_api && sudo chown -R $USER:$USER . && cd ..


################################################
# RAILS

bundle-install: #if we install new gems, we will need to build docker again
	docker-compose run sequra_api bundle install

rspec-i:
	docker-compose run sequra_api bundle exec rails generate rspec:install

tests:
	docker-compose run sequra_api bundle exec rails spec

test:
	docker-compose run sequra_api bundle exec rails spec $(RUN_ARGS)

rspec:
	docker-compose run sequra_api bundle exec rspec -fd

run-rails-console:
	docker-compose run sequra_api bundle exec rails console

run-generate:
	docker-compose run sequra_api bundle exec rails generate $(RUN_ARGS)

db-create:
	docker-compose run sequra_api bundle exec rails db:create

db-migrate:
	docker-compose run sequra_api bundle exec rails db:migrate

db-reset:
	docker-compose run sequra_api bundle exec rails db:reset

db-up:
	docker-compose run sequra_api bundle exec rails db:up

db-down:
	docker-compose run sequra_api bundle exec rails db:down

add-migration:
	docker-compose run sequra_api bundle exec rails g migration $(RUN_ARGS)

add-model:
	docker-compose run sequra_api bundle exec rails g model $(RUN_ARGS)

rails-routes:
	docker-compose run sequra_api bundle exec rails routes