# misc config
VERBOSE = ENV['VERBOSE'] || false
DEBUG = ENV['DEBUG'] || false

# build paths
BUILD_DIR = 'build'

# source paths
LIB_DIR = 'lib'
LIB_DIRS = build_riml_path([LIB_DIR])
COMPILER_SOURCE = "#{LIB_DIR}/compiler/riml.riml"
COMPILER_OUTPUT = "#{BUILD_DIR}/compiler/riml.vim"
COMPILER_OUTPUT_DIR = File.dirname(COMPILER_OUTPUT)

# test paths
TEST_DIR = 'spec'
TEST_LIB_DIRS = build_riml_path([TEST_DIR])

# speckle paths
SPECKLE_LIB_DIRS = "#{LIB_DIRS}:#{TEST_LIB_DIRS}"

# vim destinations
COMPILER_DEST = 'compiler/riml.vim'

# clean task config
CLEAN.include("#{BUILD_DIR}/**/*.vim")
CLEAN.include("#{BUILD_DIR}/**/*.log")
CLEAN.include(COMPILER_DEST)
CLOBBER.include(BUILD_DIR)
