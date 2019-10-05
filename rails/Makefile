.PHONY: development
development:
ifdef C9_PID
	@echo "Trick c9 into showing testing link:"
	@echo "server is running at 0.0.0.0:8080"
endif
	ansible-vault decrypt \
		--vault-password-file ../ansible/.vault_pass \
		--output config/secrets.yml \
		../ansible/initialize_app/resources/rails_secrets.yml
	bundle exec rails s -b 0.0.0.0 -p 8080

.PHONY: db_create
db_create:
	sudo docker create --name db --env-file .env -p 3306:3306 mysql:8 --default-authentication-plugin=mysql_native_password
	@echo "To start container, run 'make db_start'"
	@echo "To stop container, run 'make db_stop'"
	@echo "To view logs, run 'make db_logs'"

.PHONY: db_start
db_start:
	sudo docker start db
	@echo "To stop container, run 'make db_stop'"
	@echo "To view logs, run 'make db_logs'"

.PHONY: db_stop
db_stop:
	sudo docker stop db
	@echo "To start container, run 'make db_start'"
	@echo "To view logs, run 'make db_logs'"

.PHONY: db_logs
db_logs:
	@echo "To exit logs, type Control-C (^C)"
	sudo docker logs -f db

.PHONY: secrets_edit
secrets_edit:
	ansible-vault edit \
		--vault-password-file ../ansible/.vault_pass \
		../ansible/initialize_app/resources/rails_secrets.yml

.PHONY: clean
clean:
	sudo docker container prune -f
	sudo docker image prune -f
	sudo docker volume prune -f
