include_recipe 'apt'

case node['postgresql']['pgdg']['release_apt_codename']
when "etch", "lenny", "lucid", "precise", "sid", "squeeze", "wheezy"
  apt_repository 'apt.postgresql.org' do
    uri 'http://apt.postgresql.org/pub/repos/apt'
    distribution "#{node['postgresql']['pgdg']['release_apt_codename']}-pgdg"
    components %w(main)
    key 'http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc'
    action :add
  end
when "quantal", "oneiric"
  apt_repository 'pitti-postgresql-ppa' do
    uri 'http://ppa.launchpad.net/pitti/postgresql/ubuntu'
    distribution node['lsb']['codename']
    components %w(main)
    keyserver 'keyserver.ubuntu.com'
    key '8683D8A2'
    action :add
  end
else
  raise "Not supported release by PGDG apt repository"
end
