src_dir = File.join(File.dirname(__FILE__), "initializers")
dest_dir = File.join(File.dirname(__FILE__), "..", "..", "..", "config", "initializers")

Dir.glob(File.join(File.dirname(__FILE__), "initializers", "*.rb")) do |name|
  dest = File.join(dest_dir, File.basename(name))
  
  if(File.exists?(dest))
    p "file exists, not overwriting - #{dest}"
    p "sample file from plugin can be found here - #{name}"
  else
    p "copying config to #{dest}"
    FileUtils.cp(name, dest)
  end
end
