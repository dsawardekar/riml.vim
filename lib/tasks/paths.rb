# misc config
VERBOSE = ENV['VERBOSE'] || false
DEBUG = ENV['DEBUG'] || false

# build paths
BUILD_DIR = 'build'

# source paths
LIB_DIR = 'lib'
LIB_DIRS = build_riml_path([LIB_DIR])

# syntastic 
SYNTASTIC_SOURCE = "#{LIB_DIR}/riml_syntax_checker.riml"
SYNTASTIC_OUTPUT = "#{BUILD_DIR}/riml_syntax_checker.vim"
SYNTASTIC_OUTPUT_DIR = File.dirname(SYNTASTIC_OUTPUT)

# test paths
TEST_DIR = 'spec'
TEST_LIB_DIRS = build_riml_path([TEST_DIR])

# speckle paths
SPECKLE_LIB_DIRS = "#{LIB_DIRS}:#{TEST_LIB_DIRS}"

# vim destinations
SYNTASTIC_DEST = 'syntax_checkers/riml/riml.vim'

# clean task config
CLEAN.include("#{BUILD_DIR}/**/*.vim")
CLEAN.include("#{BUILD_DIR}/**/*.log")
CLEAN.include(SYNTASTIC_DEST)
CLOBBER.include(BUILD_DIR)
