from fabric.api import *
from fabric.contrib.files import exists
from loom import puppet
from loom.tasks import *
from loom.utils import upload_dir
import os

# Change to same dir as fabfile
os.chdir(os.path.dirname(__file__))

# Uncomment to use specific versions of puppet/librarian-puppet
#env.puppet_ver = '2.7.19'
#env.librarian_ver = '0.9.6'

env.user = 'root'
env.puppetmaster_host = 'zarquon.trollop.org'
env.environment = os.environ.get('ENVIRONMENT', 'production')

if env.environment == 'production':
    env.roledefs = {
        'zarquon': ['zarquon.trollop.org'],
        'zaphod': ['zaphod.trollop.org'],
    }

@task
def deploy_puppet():
    execute(puppet.update, role='puppetmaster')
    all()
    execute(puppet.force)

