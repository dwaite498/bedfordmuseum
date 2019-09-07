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

RUN_SERVER_DIR := $(PWD)/.run_server

.PHONY: initialize_app
initialize_app:
	mkdir -p $(RUN_SERVER_DIR)/rails
	cp initialize_app/resources/docker-compose.yml $(RUN_SERVER_DIR)/
	sudo docker build -t rails ../rails
	sudo docker save rails:latest > $(RUN_SERVER_DIR)/rails/image.tar
	cp initialize_app/resources/rails_secrets.yml $(RUN_SERVER_DIR)/rails/
	cp -rp initialize_app/resources/nginx $(RUN_SERVER_DIR)/
	DEPLOY_FILES_DIR=$(RUN_SERVER_DIR) ansible-playbook \
		--vault-password-file .vault_pass -i inventory \
		initialize_app/main.yml

.PHONY: run_app
run_app:
	ansible-playbook \
		--vault-password-file .vault_pass -i inventory \
		run_app/main.yml

.PHONY: run_app_edit_secrets
run_app_edit_secrets:
	ansible-vault edit \
		--vault-password-file .vault_pass \
		run_app/secrets.yml

.PHONY: edit_common_secrets
edit_common_secrets:
	ansible-vault edit \
		--vault-password-file .vault_pass \
		common_secrets.yml

.PHONY: clean
clean:
	sudo rm -rf $(RUN_SERVER_DIR)
	sudo docker container prune -f
	sudo docker image prune -f
