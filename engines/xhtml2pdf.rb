begin
  cmd = "which xhtml2pdf"
  unless system cmd
    puts "xhtml2pdf not found, please install it."
    exit
  end
end

module Xhtml2pdf

  def binary
    "xhtml2pdf"
  end

  def quiet_option
    "-q"
  end

  def debug_option
    "-d"
  end

  def stylesheets *sheets
    sheets.flatten.inject(""){|str,sheet| str + "--css=#{sheet.to_s} " } unless sheets.first.nil?
  end

  def source src
    case
    when File.exist?(src)
      [src, File]
    when src =~ /^http/
      [src, URI]
    when src.kind_of?(String)
      ["-", IO]
    else
      raise ArgumentError, "Source is invalid.", caller
    end
  end

  def destination dest
    case
    when dest.is_a?(String)
      [dest, File]
    when dest.nil?
      ["-", IO]
    else
      raise ArgumentError, "Destination is invalid.", caller
    end
  end

end