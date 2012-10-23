from fabric.api import *
from fabric.contrib.files import exists
from loom import puppet
from loom.tasks import *
from loom.utils import upload_dir
import os

# Change to same dir as fabfile
os.chdir(os.path.dirname(__file__))

env.user = 'root'
env.puppetmaster_host = 'zarquon.trollop.org'
env.environment = os.environ.get('ENVIRONMENT', 'production')

if env.environment == 'production':
    env.roledefs = {
        'zarquon': ['zarquon.trollop.org'],
    }

@task
def deploy_puppet():
    execute(puppet.update, role='puppetmaster')
    all()
    execute(puppet.force)

@task
def site_hack():
    """
    This is a hack to get around a non-manageable site.pp, which
    is required for puppetlabs/firewall to function properly.
    """
    upload_dir('manifests/', '/etc/puppet/manifests', use_sudo=True)

