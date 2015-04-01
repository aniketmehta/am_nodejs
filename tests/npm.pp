include 'am_nodejs'

am_nodejs::npm { 'express|/tmp/npm':
  ensure  => '2.5.9',
}
