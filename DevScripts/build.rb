require "pp"

WORKSPACE = "bang.xcworkspace"
SCHEME = "bang"

PWD = File.expand_path(File.dirname(__FILE__)).strip
BASE_DIR = "#{PWD}/../"
OUTPUT_DIR = "#{BASE_DIR}build"

def show_man()
  puts "usage: ruby build.rb ( debug_build | adhoc_build )"
end

def exec(command)
  puts command
  puts result = system(command)
  unless result
    exit
  end
end

def clean(configuration)
  exec("rm -rf #{OUTPUT_DIR}")
  exec("
	  xctool \
	  -workspace #{WORKSPACE} \
	  -scheme #{SCHEME} \
	  -configuration #{configuration} \
	  clean
  ")
end

def build(configuration)
  exec("
	  xctool \
	  -workspace #{WORKSPACE} \
	  -scheme #{SCHEME} \
	  -configuration #{configuration} \
    -sdk iphonesimulator8.1 \
	  build \
    CONFIGURATION_BUILD_DIR=#{OUTPUT_DIR} \
	  ONLY_ACTIVE_ARCH=NO
  ")
end

def test()
  exec("
	  xctool \
	  -workspace #{WORKSPACE} \
	  -scheme #{SCHEME} \
	  test \
	  -test-sdk iphonesimulator \
	  -parallelize
  ")
end

def debug_build()
  clean('Debug')
  build('Debug')
end

def alhoc_build()
  clean('ADHOC')
  build('ADHOC')
end

def main()
  if ARGV.empty?
    show_man()
  else
    puts func = ARGV[0]
    self.send(func)
  end
end

main()
