puppet-hostnamefacts
####################


A very simple module to provide hostname facts for stanardised hostnames.
I tend to use the following convention for hostnames::

  <environment>-<role>-<node-number>

An example of this would be::

  test-koji-builder-001

The facts this would generate would be::

  hostfact_environment     => test
  hostfact_role            => koji-builder
  hostfact_node_number_raw => 001
  hostfact_node_number     => 1
