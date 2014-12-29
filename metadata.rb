maintainer       "Colin Surprenant"
maintainer_email "colin.surprenant@gmail.com"
license          "MIT License"
description      "installs and configures Apache Storm"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.0"
name             "storm"

%w(
  logrotate
).each do |cb|
  depends cb
end

