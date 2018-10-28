# encoding: utf-8
# copyright: 2018, Kevin Kingsbury

control 'tools-01' do
  impact 1.0
  title 'Check Java Versions '
  %w(
    1.6.0_45
    1.7.0_79
    1.8.0_162
  ).each do |version|
    describe file("/opt/jdk#{version}") do
      it { should be_directory }
    end
    describe command("/opt/jdk#{version}/bin/java -version") do
      its('stderr') { should match (/java version \"#{version}\"/) }
    end
  end
end

control 'tools-02' do
  impact 1.0
  title 'Check Ant Versions '
  %w(
    1.9.7
    ).each do |version|
    describe file("/opt/apache-ant-#{version}") do
      it { should be_directory }
    end
    describe command("JAVA_HOME=/opt/jdk1.6.0_45 /opt/apache-ant-#{version}/bin/ant -version") do
      its('stdout') { should match (/#{version}/) }
    end
  end
end
