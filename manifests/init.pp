# == Class: nodejs: See README.md for documentation.
class am_nodejs(
  $cmd_exe_path                = $am_nodejs::params::cmd_exe_path,
  $legacy_debian_symlinks      = $am_nodejs::params::legacy_debian_symlinks,
  $manage_package_repo         = $am_nodejs::params::manage_package_repo,
  $nodejs_debug_package_ensure = $am_nodejs::params::nodejs_debug_package_ensure,
  $nodejs_debug_package_name   = $am_nodejs::params::nodejs_debug_package_name,
  $nodejs_dev_package_ensure   = $am_nodejs::params::nodejs_dev_package_ensure,
  $nodejs_dev_package_name     = $am_nodejs::params::nodejs_dev_package_name,
  $nodejs_package_ensure       = $am_nodejs::params::nodejs_package_ensure,
  $nodejs_package_name         = $am_nodejs::params::nodejs_package_name,
  $npm_package_ensure          = $am_nodejs::params::npm_package_ensure,
  $npm_package_name            = $am_nodejs::params::npm_package_name,
  $npm_path                    = $am_nodejs::params::npm_path,
  $repo_class                  = $am_nodejs::params::repo_class,
  $repo_enable_src             = $am_nodejs::params::repo_enable_src,
  $repo_ensure                 = $am_nodejs::params::repo_ensure,
  $repo_pin                    = $am_nodejs::params::repo_pin,
  $repo_priority               = $am_nodejs::params::repo_priority,
  $repo_proxy                  = $am_nodejs::params::repo_proxy,
  $repo_proxy_password         = $am_nodejs::params::repo_proxy_password,
  $repo_proxy_username         = $am_nodejs::params::repo_proxy_username,
  $use_flags                   = $am_nodejs::params::use_flags,
) inherits am_nodejs::params {

  validate_bool($legacy_debian_symlinks)
  validate_bool($manage_package_repo)

  if $manage_package_repo and !$repo_class {
    fail("${module_name}: The manage_package_repo parameter was set to true but no repo_class was provided.")
  }

  if $nodejs_debug_package_name {
    validate_string($nodejs_debug_package_name)
  }

  if $nodejs_dev_package_name {
    validate_string($nodejs_dev_package_name)
  }

  if $npm_package_name {
    validate_string($npm_package_name)
  }

  validate_array($use_flags)

  include '::am_nodejs::install'

  anchor { '::am_nodejs::begin': }
  anchor { '::am_nodejs::end': }

  if $manage_package_repo {
    include $repo_class
    Anchor['::am_nodejs::begin'] ->
    Class[$repo_class] ->
    Class['::am_nodejs::install'] ->
    Anchor['::am_nodejs::end']
  }
}
