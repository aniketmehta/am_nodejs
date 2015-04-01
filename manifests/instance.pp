class am_nodejs::instance (
  $am_nodejs_instances = {
    # these values you will see as default in your ENC like The Foreman
         manage_repo     => true,
         node_pkg        => 'nodejs',
         npm_pkg         => 'npm',
         version         => 'present'
  },
  $am_nodejs_instances_defaults = {
         manage_repo     => true,
         node_pkg        => 'nodejs',
         npm_pkg         => 'npm',
         version         => 'present'
  },
) {

  # load default stuff like system user, group, etc
  require am_nodejs

  # call tomcats::install define to configure each tomcat instance
  create_resources(am_nodejs, $am_nodejs_instances, $am_nodejs_instances_defaults)
}
