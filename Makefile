#### Local Development

RUN_DIR := $(PWD)/.run
SERVER_NAME ?= localhost
ifdef C9_PID
	# Override SERVER_NAME to support Cloud9 development workflow
	REGION_ID := $(shell curl -s http://169.254.169.254/latest/dynamic/instance-identity/document \
		| python -c "import json,sys; print json.loads(sys.stdin.read())['region']")
	SERVER_NAME := $(C9_PID).vfs.cloud9.$(REGION_ID).amazonaws.com
endif
PORT ?= 8080
COMPOSE_ENV := SERVER_NAME=$(SERVER_NAME) PORT=$(PORT) VOLUME_MOUNTS_DIR=$(RUN_DIR)

.PHONY: development
.PHONY: production
development production: %: real-%
ifdef C9_PID
	@echo "Trick c9 into showing testing link:"
	@echo "server is running at 0.0.0.0:8080"
else
	@echo "server is running at http://$(SERVER_NAME):$(PORT)"
endif
	@echo "To run rake or rails commands in the rails container, run 'make exec_rails'"
	@echo "To access the postgres container, run 'make exec_postgres'"
	@echo "To access the nginx container, run 'make exec_nginx'"
	@echo "To view logs, run 'make logs'"
	@echo "To quit, run 'make quit'"

.PHONY: real-development
real-development: run_setup
	$(COMPOSE_ENV) docker-compose up -d

.PHONY: real-production
real-production: run_setup
	ENVIRONMENT=production $(COMPOSE_ENV) docker-compose up -d

.PHONY: quit
quit:
	$(COMPOSE_ENV) docker-compose down

.PHONY: exec_rails
exec_rails:
	$(COMPOSE_ENV) docker-compose exec rails sh

.PHONY: exec_postgres
exec_postgres:
	$(COMPOSE_ENV) docker-compose exec db sh

.PHONY: exec_nginx
exec_nginx:
	$(COMPOSE_ENV) docker-compose exec nginx sh

.PHONY: logs
logs:
	$(COMPOSE_ENV) docker-compose logs -f

.PHONY: edit_rails_secrets
edit_rails_secrets:
	ansible-vault edit \
		--vault-password-file ansible/.vault_pass \
		ansible/run_app/rails_secrets.yml

#### Server Management

RUN_SERVER_DIR := $(PWD)/.run_server

.PHONY: setup_server
setup_server:
	ansible-playbook \
		--vault-password-file ansible/.vault_pass \
		-i ansible/inventory ansible/setup/main.yml

.PHONY: run_server
run_server: rails_image
	mkdir -p $(RUN_SERVER_DIR)/run
	sudo docker save bedford_rails:latest > $(RUN_SERVER_DIR)/bedford_rails.tar
	cp docker-compose.yml $(RUN_SERVER_DIR)/
	cp -r nginx $(RUN_SERVER_DIR)/run/
	ansible-vault decrypt \
		--vault-password-file ansible/.vault_pass \
		--output $(RUN_SERVER_DIR)/run/rails_secrets.yml \
		$(PWD)/ansible/run_app/rails_secrets.yml
	DEPLOY_FILES_DIR=$(RUN_SERVER_DIR) ansible-playbook \
		--vault-password-file ansible/.vault_pass \
		-i ansible/inventory ansible/run_app/main.yml

.PHONY: resetdb_server
resetdb_server:
	ansible-playbook \
		--vault-password-file ansible/.vault_pass \
		-i ansible/inventory ansible/reset_database/main.yml

.PHONY: migratedb_server
migratedb_server:
	ansible-playbook \
		--vault-password-file ansible/.vault_pass \
		-i ansible/inventory ansible/migrate_database/main.yml

.PHONY: loadcontent_server
loadcontent_server:
	ansible-playbook \
		--vault-password-file ansible/.vault_pass \
		-i ansible/inventory ansible/load_content/main.yml

#### Shared Steps

.PHONY: rails_image
rails_image:
	docker build -t bedford_rails ./rails

.PHONY: run_setup
run_setup: rails_image
	sudo rm -rf rails/tmp
	mkdir -p $(RUN_DIR)/db $(RUN_DIR)/static/membersprotected
	touch $(RUN_DIR)/static/index.html $(RUN_DIR)/static/membersprotected/index.html
	cp -r nginx $(RUN_DIR)/
	ansible-vault decrypt \
		--vault-password-file ansible/.vault_pass \
		--output $(RUN_DIR)/nginx/htpasswd \
		$(RUN_DIR)/nginx/htpasswd
	ansible-vault decrypt \
		--vault-password-file ansible/.vault_pass \
		--output $(RUN_DIR)/rails_secrets.yml \
		$(PWD)/ansible/run_app/rails_secrets.yml
	ln -fs $(PWD)/rails $(RUN_DIR)/

