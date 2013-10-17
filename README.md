katello-docker
==============

This repo is for running katello within a linux container (LXC) using docker.
Its aim is to help in developing katello while keeping katello's dependencies
(pulp, candlepin, ruby, postgres, etc) off the host OS.

## Prequisites

### docker

First you'll need to install docker. If you're on Fedora 20 or later, just run:

```
sudo yum install docker-io
```

For Fedora 19, run this to get a docker repo:

```
curl http://goldmann.fedorapeople.org/repos/docker.repo > /etc/yum.repos.d/docker-goldmann.repo
yum install docker-io
```

I recommend enabling docker as a service:

```
systemctl enable docker.service
```

Now start up docker:

```
systemctl start docker.service
```

### IP forwarding

In order to access the internet, on your host machine, you'll need to turn on
ip forwarding by running:

```
sysctl -w net.ipv4.ip_forward=1
```

This won't be permanent though. In order to automatically run this when you
restart, create a file `/etc/sysctl.d/80-docker.conf` and add:

```
net.ipv4.ip_forward = 1
```

I'd recommend restarting at this point.


## Setting up katello-docker

To start out with clone this repo, and cd into it. Now use docker to build your
image:

```
docker build .
```

That's it! Docker will set up the image, install katello, etc.


## Running katello

Now you want to run the container. You'll also need to mount in your git
checkouts. To do this, run:

```
docker run -i -t -v ~/Projects:/katello fa83759d328 /bin/bash
```

Where `~/Projects` is your local directory containing your katello,
katello_cli, etc. folders. Don't worry if there are other files in there.

Also, this assumes your images is `fa83759d328`. To find a list of your images
you can run:

```
docker images
```
