name             'agilefant'
maintainer       'computerlyrik'
maintainer_email 'chef-cookbooks@computerlyrik.de'
license          'Apache 2.0'
description      'Installs/Configures agilefant'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'application_java'

depends 'mysql'
depends 'database'
