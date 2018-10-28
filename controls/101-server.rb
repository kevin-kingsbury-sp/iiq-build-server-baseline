# encoding: utf-8
# copyright: 2018, Kevin Kingsbury

control 'server-01' do
  impact 1.0
  title 'Check OS Version information'
  describe os do
    its('name') { should eq 'centos' }
    its('family') { should eq 'redhat' }
    its('release') { should eq '7.3.1611' }
  end
end
