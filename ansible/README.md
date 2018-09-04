# Provisioning and Deployment Automation

Server provisioning and deployment are automated using Ansible. This guide walks through the steps
required to provision a new server instance. The work can be broken down into 3 steps:

1. Perform local setup
2. Create a new droplet
3. Run the automated provisioning

## Local setup

First, make sure [Ansible is supported](http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#control-machine-requirements)
on your operating system. If so, ensure you have Python and pip installed, and then install Ansible
(and one other requirement) by running `$ sudo pip install -r requirements.txt` from the root of
this repository.

Next, install [docker](https://docs.docker.com/install/) and
[docker-compose](https://docs.docker.com/compose/install/).

Next, you'll just need to create the file `/ansible/.vault_pass`. From the repository's root:

    $ touch ansible/.vault_pass
    $ chmod 0600 ansible/.vault_pass
    $ nano ansible/.vault_pass

The file should contain the ansible-vault password on a single line. Do not commit this file to git
(it is listed in the .gitignore, but be careful all the same).

## Droplet creation

1. Ensure your ssh public key has been added to your DigitalOcean account.
2. Create a new droplet on DigitalOcean. Here are the options we've been using:

    - Debian 9.5 x64
    - Standard 1GB mem, 1 vCPU, 25 GB SSD, 1 TB transfer at $5/mo
    - Add a 20 GB block storage volume and choose Manually Format & Mount
    - New York 3 datacenter region
    - Choose your SSH key

3. Add the droplet to the DigitalOcean firewall named Common. If you don't have access to this one,
you can create your own. It should only allow SSH (TCP port 22) and HTTP (TCP port 80) inbound
traffic. All outbound traffic is allowed.
4. Replace the IP address in the `/ansible/inventory` file in this repository with the one for your
new droplet.

## Running the automated provisioning

Now that everything is set up, it's time to provision the new server. You can do this using the
Makefile in the repo root:

    $ make setup_server run_server

After you've created the new server, you'll need to transfer the static content in. You could do
this in multiple ways: attach an existing volume with a copy of the data, scp between droplets,
etc. We should make this easier.

You'll also need to either transfer in an existing database or initialize a new one by going into
the running rails container and running `RAILS_ENV=production rake db:up_to_you`.

## Replacing the production server

The bedfordvamuseum.org domain points to a DigitalOcean floating IP address. The advantage of doing
this instead of point it to the droplet's IP directly is that we can swap out our droplet for a new
one instantaneously by reassigning the floating IP.

If swapping out the production droplet is your goal, first verify that everything looks good with
the new droplet, then reassign the floating IP. At this point, you can destory or do whatever with
the old droplet since it will no longer be receiving production traffic.

## References

The following articles and tools were influential in the provisioning design:

- [Lynis - Open source security auditing](https://cisofy.com/lynis/)
- [Lynis MAIL-8818](https://cisofy.com/controls/MAIL-8818/)
- [Securing a Server with Ansible](https://ryaneschinger.com/blog/securing-a-server-with-ansible/)
by Ryan Eschinger
- [7 Security Measures to Protect Your Servers](https://www.digitalocean.com/community/tutorials/7-security-measures-to-protect-your-servers)
by Justin Ellingwood
- [How to harden Ubuntu Server 16.04 security in five steps](https://www.techrepublic.com/article/how-to-harden-ubuntu-server-16-04-security-in-five-steps/)
by Jack Wallen
- [Initial Server Setup with Debian 8](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-debian-8)
by Mitchell Anicas
- [Deploying NGINX and NGINX Plus with Docker](https://www.nginx.com/blog/deploying-nginx-nginx-plus-docker/)
by Rick Nelson
