from fabric.api import *
from fabric.contrib.files import exists
from loom import puppet
from loom.tasks import *
from os import chdir, path, environ

# Change to same dir as fabfile
chdir(path.dirname(__file__))

env.loom_puppet_autosign = True
#env.loom_puppet_version = '2.7.19'
#env.loom_librarian_version = '0.9.6'

env.user = 'root'
env.puppetmaster_host = 'zarquon.trollop.org'
env.environment = environ.get('ENVIRONMENT', 'production')

if env.environment == 'production':
    env.roledefs = {
        'zarquon': ['trollop.org'],
    }

@task
def deploy_puppet():
    execute(puppet.update, role='puppetmaster')
    all()
    execute(puppet.force)

