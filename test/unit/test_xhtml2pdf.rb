ENV['DATA2PDF'] = 'Xhtml2pdf'

require 'helper'

class TestXhtml2pdf < Test::Unit::TestCase

  should_implement_data2pdf_interface

  should_render_pdf_from_file

  should_render_pdf_from_STDIN

  should_render_with_css_option

end