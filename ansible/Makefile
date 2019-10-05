.PHONY: initialize_server
initialize_server:
	ansible-playbook \
		--vault-password-file .vault_pass -i inventory \
		initialize_server/main.yml

.PHONY: initialize_server_edit_secrets
initialize_server_edit_secrets:
	ansible-vault edit \
		--vault-password-file .vault_pass \
		initialize_server/secrets.yml

DEPLOY_FILES_DIR := $(PWD)/.run_server

.PHONY: initialize_app
initialize_app: prepare_deploy_files
	DEPLOY_FILES_DIR=$(DEPLOY_FILES_DIR) ansible-playbook \
		--vault-password-file .vault_pass -i inventory \
		initialize_app/main.yml

.PHONY: run_app
run_app:
	ansible-playbook \
		--vault-password-file .vault_pass -i inventory \
		run_app/main.yml

.PHONY: update_app
update_app: prepare_deploy_files
	DEPLOY_FILES_DIR=$(DEPLOY_FILES_DIR) ansible-playbook \
		--vault-password-file .vault_pass -i inventory \
		update_app/main.yml

.PHONY: edit_common_secrets
edit_common_secrets:
	ansible-vault edit \
		--vault-password-file .vault_pass \
		common_secrets.yml

.PHONY: clean
clean:
	sudo rm -rf $(DEPLOY_FILES_DIR)
	sudo docker container prune -f
	sudo docker image prune -f
	sudo docker volume prune -f

.PHONY: prepare_deploy_files
prepare_deploy_files:
	mkdir -p $(DEPLOY_FILES_DIR)/rails
	cp initialize_app/resources/docker-compose.yml $(DEPLOY_FILES_DIR)/
	ansible-vault decrypt \
		--vault-password-file .vault_pass \
		--output ../rails/config/secrets.yml \
		initialize_app/resources/rails_secrets.yml
	sudo docker build -t rails ../rails
	sudo docker save rails:latest > $(DEPLOY_FILES_DIR)/rails/image.tar
	cp -rp initialize_app/resources/nginx $(DEPLOY_FILES_DIR)/
