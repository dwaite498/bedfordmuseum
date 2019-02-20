#### Development

IP ?= 0.0.0.0
PORT ?= 8080

.PHONY: development
development:
ifdef C9_PID
	@echo "Trick c9 into showing testing link:"
	@echo "server is running at 0.0.0.0:8080"
endif
	cd rails && bundle exec rails s -b $(IP) -p $(PORT)

.PHONY: db_container_create
db_container_create:
	sudo docker create --name db --env-file .env -p 3306:3306 mysql:8 --default-authentication-plugin=mysql_native_password
	@echo "To start container, run 'make db_container_start'"
	@echo "To stop container, run 'make db_container_stop'"
	@echo "To view logs, run 'make db_container_logs'"

.PHONY: db_container_start
db_container_start:
	sudo docker start db
	@echo "To stop container, run 'make db_container_stop'"
	@echo "To view logs, run 'make db_container_logs'"

.PHONY: db_container_stop
db_container_stop:
	sudo docker stop db
	@echo "To start container, run 'make db_container_start'"
	@echo "To view logs, run 'make db_container_logs'"

.PHONY: db_container_logs
db_container_logs:
	@echo "To exit logs, type Control-C (^C)"
	sudo docker logs -f db

.PHONY: secrets_load
secrets_load:
	ansible-vault decrypt \
		--vault-password-file ansible/.vault_pass \
		--output rails/config/secrets.yml \
		ansible/playbooks/resources/rails_secrets.yml

.PHONY: secrets_edit
secrets_edit:
	ansible-vault edit \
		--vault-password-file ansible/.vault_pass \
		ansible/playbooks/resources/rails_secrets.yml

#### Cleanup

.PHONY: clean
clean:
	sudo docker container prune -f
	sudo docker image prune -f
