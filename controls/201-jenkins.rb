# encoding: utf-8
# copyright: 2018, Kevin Kingsbury

data_params = yaml(content: inspec.profile.file('params.yml')).params
jenkins_version = data_params['jenkins_version']

control 'jenkins-01' do
  impact 1.0
  title 'Install jenkins package'

  describe package('jenkins') do
    it { should be_installed }
    its('version') { should cmp == jenkins_version }
  end
end

control 'jenkins-02' do
  impact 1.0
  title 'Port 8080 is listening'

  # Service should be listening on port 8080
  describe port(8080) do
    it { should be_listening }
  end
end

control 'jenkins-03' do
  impact 1.0
  title 'Check firewall ports'

  only_if 'Firewall is not enabled on this system' do
    firewalld.installed?
  end

  describe firewalld do
    it { should be_running }
    it { should have_service_enabled_in_zone('http', 'public') }
    it { should have_port_enabled_in_zone('8080/tcp', 'public') }
  end
end
