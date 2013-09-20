# helpers
def build_riml_path(dirs, pattern = /.*\.riml$/)
  libs = []
  dirs.each do |dir|
    Find.find(dir) do |path|
      if path =~ pattern
        libs << File.dirname(path)
      end
    end
  end

  libs.uniq.join(':')
end

def move_to(from, to)
  to_dir = File.dirname(to)
  to_name = File.basename(to)
  from_name = File.basename(from)

  mkdir_p to_dir
  mv from, to_dir

  new_from = "#{to_dir}/#{from_name}"
  new_to = "#{to_dir}/#{to_name}"

  unless new_from == new_to
    mv new_from, new_to
  end
end
