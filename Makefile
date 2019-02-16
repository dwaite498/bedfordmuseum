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
COMPOSE_ENV := SERVER_NAME=$(SERVER_NAME) PORT=$(PORT) DATA_DIR=$(RUN_DIR) CONFIG_DIR=$(RUN_DIR)
COMPOSE := $(shell which docker-compose)

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
	sudo $(COMPOSE_ENV) $(COMPOSE) up -d

.PHONY: real-production
real-production: run_setup
	sudo ENVIRONMENT=production $(COMPOSE_ENV) $(COMPOSE) up -d

.PHONY: quit
quit:
	sudo $(COMPOSE_ENV) $(COMPOSE) down

.PHONY: exec_rails
exec_rails:
	sudo $(COMPOSE_ENV) $(COMPOSE) exec rails sh

.PHONY: exec_postgres
exec_postgres:
	sudo $(COMPOSE_ENV) $(COMPOSE) exec db sh

.PHONY: exec_nginx
exec_nginx:
	sudo $(COMPOSE_ENV) $(COMPOSE) exec nginx sh

.PHONY: logs
logs:
	sudo $(COMPOSE_ENV) $(COMPOSE) logs -f

.PHONY: edit_rails_secrets
edit_rails_secrets:
	ansible-vault edit \
		--vault-password-file ansible/.vault_pass \
		ansible/playbooks/resources/rails_secrets.yml

#### Server Management

RUN_SERVER_DIR := $(PWD)/.run_server

.PHONY: setup_server
setup_server:
	cd ansible; ansible-playbook \
		--vault-password-file .vault_pass -i inventory \
		playbooks/01-secure.yml \
		playbooks/02-install-dependencies.yml \
		playbooks/03-configure.yml \
		playbooks/04-set-up-volumes.yml \
		playbooks/05-add-users.yml

.PHONY: run_server
run_server: rails_image
	mkdir -p $(RUN_SERVER_DIR)/config
	sudo docker save bedford_rails:latest > $(RUN_SERVER_DIR)/bedford_rails.tar
	cp docker-compose.yml $(RUN_SERVER_DIR)/
	cp -r nginx $(RUN_SERVER_DIR)/config/
	cp ansible/playbooks/resources/rails_secrets.yml $(RUN_SERVER_DIR)/config/
	cd ansible; DEPLOY_FILES_DIR=$(RUN_SERVER_DIR) ansible-playbook \
		--vault-password-file .vault_pass -i inventory \
		playbooks/06-run-app.yml

.PHONY: restart_server
restart_server:
	cd ansible; ansible-playbook \
		--vault-password-file .vault_pass -i inventory \
		playbooks/07-restart-app.yml

#### Cleanup

.PHONY: clean
clean:
	sudo rm -rf $(RUN_SERVER_DIR) $(RUN_DIR)
	sudo docker container prune -f
	sudo docker image prune -f

#### Shared Steps

.PHONY: rails_image
rails_image:
	sudo docker build -t bedford_rails ./rails

.PHONY: run_setup
run_setup: rails_image
	sudo rm -rf rails/tmp
	mkdir -p \
		$(RUN_DIR)/db \
		$(RUN_DIR)/sftp/bedfordvamuseum/membersprotected
	touch \
		$(RUN_DIR)/sftp/bedfordvamuseum/index.html \
		$(RUN_DIR)/sftp/bedfordvamuseum/membersprotected/index.html
	cp -r nginx $(RUN_DIR)/
	ansible-vault decrypt \
		--vault-password-file ansible/.vault_pass \
		--output $(RUN_DIR)/nginx/htpasswd \
		$(RUN_DIR)/nginx/htpasswd
	ansible-vault decrypt \
		--vault-password-file ansible/.vault_pass \
		--output $(RUN_DIR)/rails_secrets.yml \
		ansible/playbooks/resources/rails_secrets.yml
	ln -fs $(PWD)/rails $(RUN_DIR)/
