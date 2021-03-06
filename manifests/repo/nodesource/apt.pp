# PRIVATE CLASS: Do not use directly.
class am_nodejs::repo::nodesource::apt {

  $enable_src = $am_nodejs::repo::nodesource::enable_src
  $ensure     = $am_nodejs::repo::nodesource::ensure
  $pin        = $am_nodejs::repo::nodesource::pin

  include ::apt

  if ($ensure == 'present') {
    apt::source { 'nodesource':
      include_src       => $enable_src,
      key               => '1655A0AB68576280',
      key_source        => 'https://deb.nodesource.com/gpgkey/nodesource.gpg.key',
      location          => 'https://deb.nodesource.com/node',
      pin               => $pin,
      release           => $::lsbdistcodename,
      repos             => 'main',
      required_packages => 'apt-transport-https ca-certificates',
    }
  }

  else {
    apt::source { 'nodesource':
      ensure => 'absent',
    }
  }
}
