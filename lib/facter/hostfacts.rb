# host_facts.rb
#
# VNU Facts that allow easier host definition via the hostname
#
# Gather the hostname fact to munge into facts


module Facter::Util::HostFact
  class << self
  @@hostname = Facter.value(:hostname)
  @@hostname_split = @@hostname.split('-')
  def hostname
    @@hostname
  end
  def hostname_split
    @@hostname_split
  end
  def environment
    @@hostname_split[0]
  end
  def node_number_raw
    @@hostname_split[-1]
  end
  def node_number
    @@hostname_split[-1].to_i
  end
  def role
    @@hostname_split[1...-1].join('-')
  end
  end
end

if Facter::Util::HostFact.hostname_split.length >= 3
  # Cut off the first part of the hostname.  This will be the environment
  # (test, acceptance, production, etc)
  Facter.add('hostfact_environment') do
    setcode do
      Facter::Util::HostFact.environment
    end
  end
  
  if Facter::Util::HostFact.hostname_split[-1].to_i != 0
    Facter.add('hostfact_node_number_raw') do
      setcode do
        Facter::Util::HostFact.node_number_raw
      end
    end
    
    Facter.add('hostfact_node_number') do
      setcode do
        Facter::Util::HostFact.node_number
      end
    end
  end
  
  Facter.add('hostfact_role') do
    setcode do
      Facter::Util::HostFact.role
    end
  end
end
