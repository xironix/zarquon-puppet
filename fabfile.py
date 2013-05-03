from fabric.api import *
from loom import puppet
from loom.tasks import *
from os import chdir, path, environ

# Change to same dir as fabfile
chdir(path.dirname(__file__))

env.loom_puppet_autosign = True
#env.loom_puppet_version = '2.7.19'
#env.loom_librarian_version = '0.9.6'

env.user = 'root'
env.port = 7442
env.puppetmaster_host = 'zarquon.esurient.local'
env.environment = environ.get('ENVIRONMENT', 'production')

if env.environment == 'production':
    env.roledefs = {
        'zarquon': ['zarquon'],
    }


@task
def deploy_puppet():
    execute(puppet.update, role='puppetmaster')
    all()
    execute(puppet.force)
