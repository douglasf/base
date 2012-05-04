require "fileutils"

# @key is pre compiled file type.
# @value is
#   :compiler, what compiler to use, the compiler must print result to stdout
#   :ending, the file ending to use after compilation
@settings = {
  "less" => {
    :compiler => "lessc",
    :ending => "css"
  },
  "haml" => {
    :compiler => "haml",
    :ending => "html"
  },
  "coffee" => {
    :compiler => "coffee -p",
    :ending => "js"
  }
}

# Compiles "file" with appropriate compiler according to @settings.
def compile_file file 
  ending = file.split(".").last
  out = "publish/#{file.reverse.sub(ending.reverse, @settings[ending][:ending].reverse).reverse}" # lol
  unless File.exist?(out)
    new_file = true
    FileUtils.makedirs(File.dirname out)
    FileUtils.touch out
  end
  if File.mtime(file) > File.mtime(out) or new_file
    result = `#{@settings[ending][:compiler]} #{file} > #{out}`
    puts "WATCHR: Wrote to #{out}" if $?.success? 
  end
end

# Starts a watchr method if no arguments are given, 
# if argument "-c file" is given it compiles the single file.
arg = ARGV.shift
unless arg == "-c"
  watch( ".*\.(#{@settings.keys.join("|")})" ) {|md| 
    compile_file md[0]
  }
  puts "Starting to watch #{@settings.keys.join(", ")}"
else
  compile_file ARGV.shift
end
