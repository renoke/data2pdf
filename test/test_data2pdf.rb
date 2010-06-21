require 'helper'

class TestData2pdf < Test::Unit::TestCase


    should '#command call binary and quiet_option methods' do
      Data2pdf.expects(:binary).returns('engine')
      Data2pdf.expects(:quiet_option).returns('-q')
      (assert_equal 'engine -q  foo.html foo.pdf', (Data2pdf.send :command, 'foo.html', 'foo.pdf'))
    end

    should '#render return pdf file name if destination is file' do
      Data2pdf.stubs(:source).returns(['some-file.html', File])
      Data2pdf.stubs(:destination).returns(['some-file.pdf', File])
      Data2pdf.stubs(:stylesheets).returns(nil)
      Data2pdf.stubs(:binary).returns('engine')
      Data2pdf.stubs(:quiet_option).returns('-q')
      io = IO.popen('ls','w+')
      IO.stubs(:popen).returns(io)
      (assert_equal 'some-file.pdf', (Data2pdf.render 'some-file.html', 'some-file.pdf'))
    end



end


