## Info
My Portable development environment. I use Vagrant to set up a preconfigured
Archlinux environment.

## Setup

Setup on a new machine:

- Download Vagrant & Virtualbox
- Run Vagrantfile
- Generate RSA key, and copy the public key to a shared folder
- Log into VM with `vagrant up`
- Create a password for my user
- Copy the public key to the `~/.ssh/known_hosts` file
- Uncomment the `ssh.username` line in the Vagrantfile
