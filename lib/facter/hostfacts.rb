# host_facts.rb
#
# VNU Facts that allow easier host definition via the hostname
#
# Gather the hostname fact to munge into facts
hostname = Facter.value(:hostname).split('-')


# Cut off the first part of the hostname.  This will be the environment
# (test, acceptance, production, etc)
Facter.add('hostfact_environment') do
  setcode do
    if hostname.length >= 3
      hostname[0]
    end
  end
end

# Get the last element of the hostname.  This should be a poitive integer.
# It will be returned as it appears in the hostname.
Facter.add('hostfact_node_number_raw') do
  setcode do
    hostname_int = hostname[-1].to_i
    if hostname.length >= 3
      if hostname_int != 0
        hostname[-1]
      end
    end
  end
end

# Get the last element of the hostname.  This should be a poitive integer.
# It will be returned as an integer with no leading zeros.
Facter.add('hostfact_node_number') do
  setcode do
    hostname_int = hostname[-1].to_i
    if hostname.length >= 3
      if hostname_int != 0
        hostname_int
      end
    end
  end
end

# Get the string between the environment and the node number.
# This should depict the role of the host.
Facter.add('hostfact_role') do
  setcode do
    if hostname.length >= 3
      hostname[1...-1].join('-')
    end
  end
end
