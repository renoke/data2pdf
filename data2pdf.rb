=begin rdoc
  render "www.google.ch"                        => STDOUT       (strings)
  render "www.google.ch", "out.pdf"             => out.pdf      (file)

  render "myfile.html"                          => STDOUT       (strings)
  render "myfile.html", "out.pdf"               => out.pdf      (file)

  render "This is text to render."              => STDOUT       (strings)
  render "This is text to render.", "out.pdf"   => out.pdf      (file)
=end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'engines'))
ENGINE = ENV['DATA2PDF']
autoload ENGINE.to_sym, ENGINE.downcase if ENGINE

module Data2pdf

  extend self
  extend const_get(ENGINE) if ENGINE

  def render src, dest=nil, opt={}

    src_cmd, src_type   = (source src)
    dest_cmd, dest_type = (destination dest)
    css                 = (stylesheets opt[:css])

    io = IO.popen command(src_cmd, dest_cmd, css), "w+"
    io.puts(src)  if src_type == IO
    io.close_write
    out = io.gets if dest_type == IO
    io.close

    case dest_type.to_s
    when "IO" then out
    when "File"   then dest_cmd
    end

  end

  private

    def command src, dest, sheets=nil
      "#{binary} #{quiet_option} #{sheets} #{src} #{dest}"
    end


end