# Bedford Museum Web Server Provisioning

Server provisioning is automated using Ansible. This guide walks through the steps required to
provision a new server instance. The work can be broken down into 3 steps:

1. Perform local setup
2. Create a new droplet
3. Run the automated provisioning

## Local setup

First, make sure [Ansible is supported](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#control-machine-requirements)
on your operating system. If so, ensure you have Python and pip installed, and then install Ansible
(and one other requirement) by running `$ sudo pip install -r requirements.txt` from the root of
this repository.

Next, you'll just need to create a .vault_pass file in repository root:

    touch .vault_pass
    chmod 0600 .vault_pass
    nano .vault_pass

The file should contain the ansible-vault password on a single line. Do not commit this file to git
(it is listed in the .gitignore, but be careful all the same).

## Droplet creation

1. Ensure your ssh public key has been added to your DigitalOcean account.
2. Create a new droplet on DigitalOcean. Here are the options we've been using:

    - Debian 9.4 x64
    - Standard 1GB mem, 1 vCPU, 25 GB SSD, 1 TB transfer at $5/mo
    - New York 3 datacenter region
    - Enable monitoring
    - Choose your SSH key

3. Add the droplet to the DigitalOcean firewall named Common. If you don't have access to this one,
you can create your own. It should only allow SSH (TCP port 22) and HTTP (TCP port 80) inbound
traffic. All outbound traffic is allowed.
4. Replace the IP address in the `inventory` file in this repository with the one for your new
droplet. If you want to use the server for development, leave `prod=false`. If you want to use it to
replace the production server, set `prod=true`.

## Running the automated provisioning

Now that everything is set up, it's time to provision the new server. Just run:

    $ ansible-playbook --vault-password-file .vault_pass -i inventory main.yml

This process typically takes about 30 min to 1 hour because it takes a while to transfer the 15+ GB
of static content from our DigitalOcean spaces bucket.

Note that the production server syncs its static content to the DigitalOcean spaces bucket once a
day. This is probably sufficiently recent if you're just creating a new environment for development
purposes, but if your goal is to replace the production server, you should run `rclone sync`
manually on the production server before provisioning the replacement so that you don't lose any
recent changes. Of course, be sure you're communicating proactively with the museum staff to pick an
appropriate time to do this maintaince.

## Replacing the production server

The bedfordvamuseum.org domain points to a DigitalOcean floating IP address. The advantage of doing
this instead of point it to the droplet's IP directly is that we can swap out our droplet for a new
one instantaneously by reassigning the floating IP.

If swapping out the production droplet is your goal, first verify that everything looks good with
the new droplet, then reassign the floating IP. At this point, you can destory or do whatever with
the old droplet since it will no longer be receiving production traffic.
