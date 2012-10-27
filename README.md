# Zarquon Puppet Manifests
Personal puppet manifests for managing my home server.

## Installation

Install Fabric and Loom:

    $ sudo pip install -U -r requirements.txt

If the Loom version changes in `requirements.txt`, run this command again to update.

## Deploying Puppet

    $ fab deploy_puppet

## Dependencies

* Tested with Puppet Open Source 3.0.1
* Targeted for Ubuntu 12.10

## Linting

Puppet Lint is a tool that checks various syntax and style rules common to well written Puppet code. It can be run with:

    bundle exec rake lint

This outputs a set of errors or warnings that should be fixed. See the [Puppet Style Guide](http://docs.puppetlabs.com/guides/style_guide.html) for more information.

## Written By
[Steffen L. Norgren](http://github.com/xironix)
