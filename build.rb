#!/usr/bin/env ruby -w

STDOUT.sync = true

# Script config
plist = 'source/Hues-Info.plist'
app = 'Hues'
build_dir = 'build/Release/'
private_key = '/Users/zach/Dropbox/Giant Comet/projects/shared/dsa_priv.pem'
download_url = 'http://giantcomet.com/files/hues/'
dropbox = "~/Dropbox/Giant Comet/projects/Hues"
appcast = false

# 
build = `/usr/libexec/PlistBuddy -c "Print CFBundleVersion" #{plist}`.chomp().to_i
new_build = build + 1
version = `/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" #{plist}`.chomp()
zip_file = "#{app}-#{version.gsub(' ', '')}.zip"

puts "** Building: #{version} (#{new_build}) **\n"

# Clean build
`xcodebuild clean`

# Update build version
`/usr/libexec/PlistBuddy -c "Set :CFBundleVersion #{new_build}" #{plist}`

# Perform actual build
print "Starting build..."
result = system("xcodebuild -target #{app} -configuration Release")
# `xcodebuild -target #{app} -configuration Release`

if !result
  puts "** Build failed!!! **"
  exit()
end

puts "done"

# Create zip file
Dir.chdir(build_dir)
`zip -r "#{zip_file}" #{app}.app`
# `cp #{zip_file} "#{dropbox}"`


if appcast
  # Create appcast item
  filesize = File.size(zip_file)
  pubdate = Time.now.strftime('%a, %d %b %Y %H:%M:%S %z')
  sig = `openssl dgst -sha1 -binary < "#{zip_file}" | openssl dgst -dss1 -sign "#{private_key}" | openssl enc -base64`

  puts "<item>
     <title>Version #{version}</title> 
     <description>
       <![CDATA[
         <ul>
           <li></li>
         </ul>
       ]]>
     </description>
     <pubDate>#{pubdate}</pubDate> 
      <enclosure url=\"#{download_url}#{zip_file}\" sparkle:version=\"#{new_build}\" sparkle:shortVersionString=\"#{version}\" length=\"#{filesize}\" type=\"application/octet-stream\" sparkle:dsaSignature=\"#{sig}\" /> 
   </item>"
end
 
# Open build dir in finder
`open .`