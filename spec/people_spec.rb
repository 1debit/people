require 'spec_helper'

module Peoplw
  describe "Parse standard name variations" do
    before( :each ) do
      @np = People::NameParser.new
    end

    it "should parse first initial, last name" do
      name = @np.parse( "M ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 1
      expect(name[:first]).to eq "M"
      expect(name[:last]).to eq "Ericson"
    end

    it "should parse first initial, middle initial, last name" do
      name = @np.parse( "M E ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 2
      expect(name[:first]).to eq "M"
      expect(name[:middle]).to eq 'E'
      expect(name[:last]).to eq "Ericson"
    end

    it "should parse first initial with period, middle initial with period, last name" do
      name = @np.parse( "M.E. ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 3
      expect(name[:first]).to eq "M"
      expect(name[:middle]).to eq 'E'
      expect(name[:last]).to eq "Ericson"
    end

    it "should parse first initial, two middle initials, last name" do
      name = @np.parse( "M E E  ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 4
      expect(name[:first]).to eq "M"
      expect(name[:middle]).to eq 'E E'
      expect(name[:last]).to eq "Ericson"
    end

    it "should parse first initial, middle name, last name" do
      name = @np.parse( "M EDWARD ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 5
      expect(name[:first]).to eq "M"
      expect(name[:middle]).to eq 'Edward'
      expect(name[:last]).to eq "Ericson"
    end

    it "should parse first name, middle initial, last name" do
      name = @np.parse( "MATTHEW E ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 6
      expect(name[:first]).to eq "Matthew"
      expect(name[:middle]).to eq 'E'
      expect(name[:last]).to eq "Ericson"
    end

    it "should parse first name, two middle initials, last name" do
      name = @np.parse( "MATTHEW E E ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 7
      expect(name[:first]).to eq "Matthew"
      expect(name[:middle]).to eq 'E E'
      expect(name[:last]).to eq "Ericson"
    end

    it "should parse first name, two middle initials with periods, last name" do
      name = @np.parse( "MATTHEW E.E. ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 8
      expect(name[:first]).to eq "Matthew"
      expect(name[:middle]).to eq 'E.E.'
      expect(name[:last]).to eq "Ericson"
    end

    it "should parse first name, last name" do
      name = @np.parse( "MATTHEW ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 9
      expect(name[:first]).to eq "Matthew"
      expect(name[:last]).to eq "Ericson"
    end

    it "should parse first name, middle name, last name" do
      name = @np.parse( "MATTHEW EDWARD ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 10
      expect(name[:first]).to eq "Matthew"
      expect(name[:middle]).to eq 'Edward'
      expect(name[:last]).to eq "Ericson"
    end

    it 'does not parse two middle names' do
      name = @np.parse( "MATTHEW EDWARD RICHARD ERICSON" )
      expect(name[:parsed]).to be false
    end

=begin
    it "should parse first name, middle initial, middle name, last name" do
      pending( "Doesn't correctly parse two middle names" ) do
        name = @np.parse( "MATTHEW E. SHEIE ERICSON" )
        puts name.inspect
      expect(  name[:parsed]).to be true
      expect(  name[:parse_type]).to eq 11
      expect(  name[:first]).to eq "Matthew"
      expect(  name[:middle]).to eq 'E. Sheie'
      expect(  name[:last]).to eq "Ericson"
      end
    end
=end

  end

  describe "Parse multiple names" do
    before( :each ) do
      @np = People::NameParser.new( :couples => true )
    end

    it "should parse multiple first names and last name" do
      name = @np.parse( "Joe and Jill Hill" )
      expect(name[:parsed]).to eq true
      expect(name[:multiple]).to be true
      expect(name[:parsed2]).to be true
      expect(name[:parse_type]).to eq 9
      expect(name[:first2]).to eq "Jill"
    end

    it "should parse multiple first names, middle initial, last name" do
      name = @np.parse( "Joe and Jill S Hill" )
      expect(name[:parsed]).to eq true
      expect(name[:multiple]).to be true
      expect(name[:parsed2]).to be true
      expect(name[:parse_type]).to eq 9
      expect(name[:first2]).to eq "Jill"
      expect(name[:middle2]).to eq 'S'
    end

    it "should parse multiple first names, middle initial, last name" do
      name = @np.parse( "Joe S and Jill Hill" )
      expect(name[:parsed]).to eq true
      expect(name[:multiple]).to be true
      expect(name[:parsed2]).to be true
      expect(name[:parse_type]).to eq 6
      expect(name[:first2]).to eq "Jill"
      expect(name[:middle]).to eq 'S'
    end
  end

  describe "Parse unusual names" do
    before( :each ) do
      @np = People::NameParser.new
    end

    it "should parse multiple-word last name" do
      name = @np.parse( "Matthew De La Hoya" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 9
      expect(name[:last]).to eq "De La Hoya"
    end

    it "should parse last name with cammel case" do
      name = @np.parse( "Matthew McIntosh" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 9
      expect(name[:last]).to eq "McIntosh"
    end
  end

  describe "Parse names with decorations" do
    before( :each ) do
      @np = People::NameParser.new
    end

    it "should parse name with the suffix 'Jr'" do
      name = @np.parse( "Matthew E Ericson Jr" )
      expect(name[:parsed]).to be true
      expect(name[:suffix]).to eq "Jr"
    end

    it "should parse name with a roman numeral suffix" do
      name = @np.parse( "Matthew E Ericson III" )
      expect(name[:parsed]).to be true
      expect(name[:suffix]).to eq "III"
    end

#   it "should parse name with an ordinal suffix" do
#     name = @np.parse( "Matthew E Ericson 2nd" )
#     expect(name[:parsed]).to be true
#     expect(name[:suffix]).to eq "2nd"
#   end

    it "should parse name with a suffix with periods" do
      name = @np.parse( "Matthew E Ericson M.D." )
      expect(name[:parsed]).to be true
      expect(name[:suffix]).to eq "M.D."
    end

    it "should parse name with a title" do
      name = @np.parse( "Mr Matthew E Ericson" )
      expect(name[:parsed]).to be true
      expect(name[:title]).to eq "Mr "
    end

    it "should parse name with a title with a period" do
      name = @np.parse( "Mr. Matthew E Ericson" )
      expect(name[:parsed]).to be true
      expect(name[:title]).to eq "Mr. "
    end

    it "should parse name with a title, first initial" do
      name = @np.parse( "Rabbi M Edward Ericson" )
      expect(name[:parsed]).to be true
      expect(name[:parse_type]).to eq 5
      expect(name[:title]).to eq "Rabbi "
      expect(name[:first]).to eq 'M'
    end

    it "should parse 1950s married couple name" do
      name = @np.parse( "Mr. and Mrs. Matthew E Ericson" )
      expect(name[:parsed]).to be true
      expect(name[:title]).to eq "Mr. And Mrs. "
      expect(name[:first]).to eq "Matthew"
    end
  end

  describe "Name case options" do
    it "should change upper case to proper case" do
      proper_np = People::NameParser.new( :case_mode => 'proper' )
      name = proper_np.parse( "MATTHEW ERICSON" )
      expect(name[:first]).to eq "Matthew"
      expect(name[:last]).to eq "Ericson"
    end

    it "should change proper case to upper case" do
      proper_np = People::NameParser.new( :case_mode => 'upper' )
      name = proper_np.parse( "Matthew Ericson" )
      expect(name[:first]).to eq "MATTHEW"
      expect(name[:last]).to eq "ERICSON"
    end

    it "should leave case as is" do
      proper_np = People::NameParser.new( :case_mode => 'leave' )
      name = proper_np.parse( "mATTHEW eRicSon" )
      expect(name[:first]).to eq "mATTHEW"
      expect(name[:last]).to eq "eRicSon"
    end
  end
end
