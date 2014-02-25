===========
docker_paas
===========

Use with caution

Overview
========

Zookeeper is the foundational component, it allows mesos, marathon, and
other components to self organize.  Zookeepr is managed by exhibitor.
Exhibitor is an application built by Netflix that manages zookeeper for you and provides a discovery API.
Exhibitor runs on each zookeeper node and uses NFS to bootstrap
configuration.  This shouldn't be a hard
dependency, if NFS is unavailable the ZK quorum isn't impacted.   In
a production environment we should use the 'S3' configuration option which moves this
configuration store to S3 (or perhaps to a Ceph object store
if we can swing it).  

Mesos runs on each node.  Running on Mesos is Marathon.  Marathon/Mesos ensures:
*services only get run where resource and other arbitrary constraints
are met.  (i.e cpu, memory, disk, rack, datacenter)
*a certain number of copies of the service are always running given
adequate resources are available in the cluster

Marathon/Mesos provides a highly available API and web interface to
add/remove/manage thess services


Tenantive Workflow
==================
- User logs into PAAS Interface (not provided...yet)
- User creates a tenant(or joins one with an auth-token) 
* Tenants are really just additional copies of marathon running under
their own zookeeper namespace running under a central marathon (marathon
running marathons).  Alternatively aurora seems to do the environment
thing better, still need to investigate...

- User recieves a git remote endpoint and YAML file they can add to their project.
* Yaml file authenticates them, describes their project, and gives
hints to the build pipeline.
- User pushes a git reference to the endpoint and a build pipeline takes
their project and converts it into a 'slug' or a re-usable docker
container with buildstep.   These are pushed to a docker registry (need
to add yourself).
- slug is automatically deployed and begins running in their tenant.

Thus to deploy to dev you'd only need to do:
git push paas-dev
or
git push paas-prod
etc..

Allowed git pushers are managed by the accounting piece yet to be
created.. for now you can use your access to the paas masters to add
your key
 cat ~/.ssh/id_rsa.pub | ssh you@yourserver.com "sudo gitreceive
upload-key <username>"
