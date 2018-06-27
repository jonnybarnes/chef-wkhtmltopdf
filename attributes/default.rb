# Used for uninstalling old recipe for wkhtmltopdf
default['wkhtmltopdf']['version']     = '0.12.0'
default['wkhtmltopdf']['install_dir'] = '/usr/local/bin'
default['wkhtmltopdf']['lib_dir']     = ''

default['wkhtmltopdf-update']['install_dir'] = '/usr/local/bin'
default['wkhtmltopdf-update']['lib_dir']     = ''
default['wkhtmltopdf-update']['version'] = '0.12.5-1'

case node['platform_family']
when 'mac_os_x', 'mac_os_x_server'
  default['wkhtmltopdf-update']['dependency_packages'] = []
  default['wkhtmltopdf-update']['platform'] = 'macosx-10.9.1-x86_64'
  default['wkhtmltopdf-update']['package'] = 'osx-cocoa-x86-64.pkg'
when 'windows'
  default['wkhtmltopdf-update']['dependency_packages'] = []
  default['wkhtmltopdf-update']['platform'] = if node['kernel']['machine'] == 'x86_64'
                                                'win64'
                                              else
                                                'win32'
                                              end
  default['wkhtmltopdf-update']['package'] = if node['kernel']['machine'] == 'x86_64'
    'msvc2015-win64.exe'
  else
    'msvc2015-win32.exe'
  end
else
  default['wkhtmltopdf-update']['dependency_packages'] = value_for_platform_family(
    %w[debian] => %w[zlib1g-dev libfontconfig1 libfreetype6-dev libxext6 libx11-dev libxrender1 fontconfig libjpeg8 xfonts-base xfonts-75dpi],
    %w[fedora rhel] => %w[fontconfig libXext libXrender openssl-devel urw-fonts]
  )

  if node['kernel']['machine'] == 'x86_64'
    default['wkhtmltopdf-update']['platform'] = 'linux-amd64'
    default['wkhtmltopdf-update']['package'] = value_for_platform_family(
      %w(debian) => "wkhtmltox_#{node['wkhtmltopdf-update']['version']}.trusty_amd64.deb",
      %w(fedora rhel) => "wkhtmltox_#{node['wkhtmltopdf-update']['version']}.centos6_amd64.rpm"
    )
  else
    default['wkhtmltopdf-update']['platform'] = 'linux-i386'
    default['wkhtmltopdf-update']['package'] = value_for_platform_family(
      %w(debian) => "wkhtmltox_#{node['wkhtmltopdf-update']['version']}.trusty_i386.deb",
      %w(fedora rhel) => "wkhtmltox_#{node['wkhtmltopdf-update']['version']}.centos6_i386.rpm")
  end

end

default['wkhtmltopdf-update']['mirror_url'] = "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/#{node['wkhtmltopdf-update']['version']}/#{node['wkhtmltopdf-update']['package']}"