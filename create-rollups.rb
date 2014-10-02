require 'optparse'

require_relative 'dependencies'
require_relative 'preprocessor'


options = {}
 
optparse = OptionParser.new do|opts|
  opts.banner = "Usage: --build to create production files"

  options[:build] = false
  opts.on("-b", "--build", "Build production files") do |v|
    options[:build] = v
  end
end
optparse.parse!

$GLOBAL_CSS = "_global"

$manifest = []

$added = {}

#get all the filenames buried in the list
DEPENDENCIES.each do |file, reqsList|
  $added[file] = false
  reqsList.each {|req| $added[req] = false}
end

def get_next
  $added.each do |file, isSeen|
    return file unless isSeen
  end
  nil
end

#now traverse the tree
def traverse(root)
  return nil if $added[root]

  deps = DEPENDENCIES[root]
  unless deps.nil? || deps == []
    deps.each do |child| 
      traverse(child)
    end   
  end

  $manifest.push(root)
  $added[root] = true
end

until (nextFile = get_next()).nil? do
  traverse(nextFile)
end

$cssManifest = []
$jsManifest = []
$manifest.each do |filename|
  if File.exist?(File.join('styles', filename+'.less'))
    $cssManifest.push(filename)
  end
  if File.exist?(File.join('scripts', filename+'.js'))
    $jsManifest.push(filename)
  else
    puts "WARN: file #{filename}.js not found"
  end
end

File.open("styles/manifest.less", "w") do |f|
  f.puts "@import \"#{$GLOBAL_CSS}\";\n"

  f.puts($cssManifest.map do |filename| 
    "/*BEGIN FILE #{filename}*/\n@import \"#{filename}\";"
  end)
end
File.open("scripts.manifest", "w") do |f|
  f.puts($jsManifest)
end

puts "Rollups created"

if options[:build]
  Preprocessor.compile_js($jsManifest)
  Preprocessor.compile_less(['manifest'])
end