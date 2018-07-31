# Bedford Museum and Genealogical Library

This is a rebuild of the Bedford Museum website. An initial straight html and css code base will be replaced with a rails app as the project progresses into the bookstore and member services sections. The goal is to add responsive aspects to the website with AJAX and JQuery. Future items and planned are listed below

 - Staff profiles and contact information for each
 - fully integrated bookstore and gift shop with rotating slideshow in main index page of selection of new or promoted books.
 - calendar of events/blog interface to increase user interaction and communication between ownership and users.
 - fully protected and administrator managed member section that allows controlled access to more sensitive aspects of the museum collections.
 - content management system for user friendly website maintenance and administration.
 - additional resources, history, and regional information that has been outside the scope of the Museums resources up to now.
 - audio/visual integration for historical records and museum event recordings.

 Additional items are anticipated but not necessarily going to be included in the current contract
 - Forum/Message board for family genealogy
 - Photo galleries for photos
 - Visual exhibits

## Contributors
 * **David Waite** - *Lead Programmer and Designer*
 * **Andrew Hershberger** - *Code and Design consultation*

## Environment Setup

Whether you're developing a new feature or just deploying the app, you'll need to follow these setup
steps:

1. Clone this repo
1. Install docker, docker-compose, and ansible
1. Add required files that are ignored by git:

    /rails/config/secrets.yml
    /ansible/.vault_pass

## Development

The development workflow is coordinated by a Makefile that provides high-level commands. Under the
hood, it's implemented with a combination of docker-compose and ansible. It's been tested on macOS
and in an AWS C9/EC2 environment.

### Workflow

1. To run the app, `$ make development` or `$ make production` (according to which environment you
want to use. This starts up 3 containers (rails, postgres, and nginx) that work together to serve
the app. It prints some helpful info (testing URL, command reference) as well.
1. To view the logs, `$ make logs`.
1. If you need to execute commands in one of the containers (for example `$ rake db:reset`), use
`$ make exec_rails`, `$ make exec_postgres`, or `$ make exec_nginx` to open a shell in the container
you need. When you're done, you can Ctrl-D to leave the container. Note that the container must
already be running for these commands to work.
1. To stop and remove the containers, use `$ make quit`
1. If you make changes that require restarting the rails app, `$ make quit` and then
`$ make development`/`$ make production`.
1. rails/config/secrets.yml is excluded from git, but an encrypted copy of it is stored in
ansible/run_app/rails_secrets.yml. The Makefile is set up to decrypt this file as needed when
running and deploying the app. To make changes to the secrets, the Makefile provides the convenient
`$ make edit_rails_secrets`, which opens the encrypted file in your `$EDITOR`. Just make your
changes, save, and close to update the file.

## Deployment

Server provisioning and app deployment is automated with ansible. For convenience, the Makefile
provides high-level commands for these tasks as well. For a full explanation of our ansible
automation, see [/ansible/README.md](ansible/README.md).

1. To provision a new server to which you have SSH access, update `ansible/inventory` with the
server's IP address and set the `prod` flag appropriately. Then run `$ make setup_server`
1. To deploy the app, run `$ make run_server`. If you have a sudo password, this step will require
you to type it.
1. To reset the database, run `$ make resetdb_server`
1. To run database migrations, run `$ make migratedb_server`
1. To load the static content from the DigitalOcean Spaces bucket, run `$ make loadcontent_server`
