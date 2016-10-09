Bitlbee Jabber OTR through Tor Docker Container
===============================================


This is a communication central point. You set it up to have a server
where you login and tmux to a irssi session. This server is trusted to
run those components and your connection to the server is expected to be
safe (public key auth vpn etc).

UCO
===

Outbound Tor client that exposes its socks port to UCD. The bitlbee
server has to use a socks proxy setting to send all communication
traffic through.

UCN
===

Local service that generates tor-keys for a given regexp.
Place a file 'pattern' in uc/config/tor-names/keys and start the service with the entrypoint /usr/local/bin/generate-keys. This service is configured with
a /bin/false entrypoint so it does not eat up your cpu by default.

UCD
===

Bitlbee server that is trusted with all the credentials to a certain
group. The server is only exposed to the internal network and serves as
irc gateway.

After some basic setup of the bitlbee service you will use bitlbee's
commandline interface to review the buddy list (blist all), but before
accounts need to be setup. All commands to the server are invoked using
the &bitlbee IRC channel with the uc frontend.
```
(# register password)
(# identify password)
 # account add jabber username@jabber.host/purpose password
 # account 0 on
```

Unfortunately the jabber-account cannot be registered. it needs to be
registered in external software. Beware that this can compromise your
identity.

The bitlbee server is configured to use UCO as proxy for connecting so
all traffic is sent through the tor network. Make sure you use ssl
and otr anyway. this only obfuscates the origin of the data (eg your
provider/country where your server is located cannot know) but can not
be used to connect to services in the tor network.

UCDT
====

Used to connect to a hidden jabber service. Expects a jabber server
that has a public or local domain name eg 'jabber.ipredator.se' or 
'jabber.lan' and a hidden service 'fwtnuwekoeayj3s7.onion' for that.

To allow bitlbee resolving the onion name, torsocks is used. This
adds a additional tor-client in the architecture that is only used
by this server. It may be possible to use uco with torsocks in the
future.

The command to setup the xmpp account for the hidden service changes.
The server has to be set using the 'account 0 set' command:
```
# account add jabber username@server.tld
# account 0 set server your-onion-siteh24-7.onion
# account 0 on
```

To use UCDT you have to modify the docker-compose.yml and
change the link of uc.

UC
==

Unified Communication is a irssi that autoconnects to the bitlbee server
ucd. This is the frontend you are constantly using. Refer to the irssi
user guide when you need more than the following:

```
Alt + Left / Right - switch between windows
PageUp / PageDown - to review history
/msg [username] . - initiate a private chat, review OTR state message
/wc - close message window
identify 'password' - in &bitlbee channel
register 'password' - in &bitlbee channel to create a new identity
```
when you encounter the error
otr save: /var/lib/bitlbee/me.otr_fprints: Permission denied
make sure you have the secrets/bitlbee directory chowned properly

UCS
===

Shell that is able to load private keys and connect to all servers
using the tor network. when clearnet domain names are used, the traffic
will still travel trough tor and certain exit nodes.

Installation
============

1. clone this repository to a local directory

```git clone https://git-url```

2. edit timezone:

  - bin/irssi.sh
  - bin/bitlbee.sh

3. build containers

```docker-compose build```

4. setup configuration ownership

chown 1000:1000 uc/secrets/bitlbee

Usage
=====

start a tmux session

```
tmux
```

change to the checkout directory

```
cd /tmp/uc
```

run the irssi client _in_ the docker session.

```
docker-compose run --rm uc
```

you now should get a irssi client that you can easily detach from (ctrl+b d) and attach later with

```
tmux attach
```

As you have to trust the computer you run this setup, verify its
consistency before launching the services. When you leave this services 
up and running for a long time, you endanger other people as the instances
could be found and analyzed. shutdown and encrypt the uc-directory with
its secrets regulary. use different machines.
