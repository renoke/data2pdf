class Test::Unit::TestCase

  def self.should_implement_data2pdf_interface

    klass = const_get( ENV['DATA2PDF'] )

    context "Module #{klass}" do

      subject{ klass }

      should 'define interface methodes' do
        assert subject.method_defined? :binary
        assert subject.method_defined? :quiet_option
        assert subject.method_defined? :debug_option
        assert subject.method_defined? :stylesheets
        assert subject.method_defined? :source
        assert subject.method_defined? :destination
      end

    end

  end # should_implement_data2pdf_interface


  def self.should_render_pdf_from_file

    context 'Rendering from file' do

      should 'create a pdf file if the destination is a file' do
        assert_exist './../fixtures/simple-text.pdf' do
          Data2pdf.render './../fixtures/simple-text.txt', './../fixtures/simple-text.pdf'
        end
      end

      should 'fill STDOUT if no destination is specified' do
        assert_match(/^%PDF/, Data2pdf.render('./../fixtures/simple-text.txt'))
      end

    end

  end # should_render_pdf_from_file


  def self.should_render_pdf_from_STDIN

    context 'Rendering from STDIN' do

      should 'create pdf file if destination is a file' do
        assert_exist './../fixtures/from-strings.pdf' do
          Data2pdf.render 'Hello World', './../fixtures/from-strings.pdf'
        end
      end

      should 'fill STDOUT if no destination is specified' do
        assert_match(/^%PDF/, Data2pdf.render('Hello World'))
      end

    end

  end # should_render_pdf_from_STDIN

  def self.should_render_with_css_option

    context 'Rendering with :css option' do

      should 'create pdf if one file is specified' do
        assert_exist './../fixtures/simple-text.pdf' do
          Data2pdf.render './../fixtures/simple-text.txt', './../fixtures/simple-text.pdf', :css=>'./../fixtures/sheet1.css'
        end
      end

      should 'create pdf if more files are specified' do
        assert_exist './../fixtures/simple-text.pdf' do
          Data2pdf.render  './../fixtures/simple-text.txt',
                            './../fixtures/simple-text.pdf',
                            :css=>['./../fixtures/sheet1.css', './../fixtures/sheet2.css']
        end
      end

    end

  end # render_with_css_option

end # Test::Unit::TestCase