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
 * **Andrew Hershberger** - *Advising and Deployment*

## Environment Setup

Whether you're developing a new feature or just deploying the app, you'll need to follow these setup
steps:

1. Clone this repo
1. Install docker, docker-compose, and ansible
1. Add required files that are ignored by git:

    /ansible/.vault_pass

## Development

The development workflow is coordinated by a Makefile that provides high-level commands. Under the
hood, it's implemented with a combination of docker and ansible. It's been tested on macOS, Ubuntu,
and AWS C9/EC2.

### Workflow

A makefile is provided inside of the rails directory for development convenience.

1. To run the app, use `$ make development`. Type Control-C (^C) to quit.
1. To create the database, use `$ make db_create`
1. To start the database, use `$ make db_start`
1. To stop the database, use `$ make db_stop`
1. To view the database logs, `$ make db_logs`
1. To delete the database, `$ make db_stop clean`
1. rails/config/secrets.yml is excluded from git, but an encrypted copy of it is stored in
ansible/run_app/rails_secrets.yml. The Makefile is set up to decrypt this file as needed when
running and deploying the app. To make changes to the secrets, the Makefile provides the convenient
`$ make secrets_edit`, which opens the encrypted file in your `$EDITOR`. Just make your
changes, save, and close to update the file.

## Deployment

Server provisioning and app deployment is automated with Ansible. A separate makefile in the ansible
directory provides high-level commands for these tasks as well. For a full explanation of our ansible
automation, see [/ansible/README.md](ansible/README.md).
