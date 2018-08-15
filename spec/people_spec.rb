require 'spec_helper'

=begin

# more test cases -- the ones with "and" might be a bit excotic

Donald Ericson
Ericson, Donald R. S
Ericson, Matthew
Matthew E. Ericson
Matt Van Ericson
Matthew E. La Ericson
M. Edward Ericson
Matthew and Ben Ericson
Mathew R. and Ben Q. Ericson
Ericson, Matthew R. and Ben Q.
MATTHEW ERICSON
MATTHEW MCDONALD
Mr. Matthew Ericson
Sir Matthew Ericson
Matthew Ericson III
Dr. Matthew Q Ericson IV
Ericson, Mr. Matthew E
Von Ericson, Dr. Matthew Edward
Angel S. Viloria III

=end

module People
  describe "Parse standard name variations" do
    before( :each ) do
      @np = People::NameParser.new
    end

    it "should parse first initial" do
      name = @np.parse( "M" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq ''
      expect(name[:last]).to eq 'M'
      expect(name[:parse_type]).to eq 0
    end

    it "should parse first initial last initial" do
      name = @np.parse( "M E" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq 'M'
      expect(name[:last]).to eq 'E'
      expect(name[:parse_type]).to eq 9
    end

    it "should parse first initial, last name" do
      name = @np.parse( "M ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "M"
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 9 # 1
    end

    it "should parse first initial, middle initial, last name" do
      name = @np.parse( "M E ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "M"
      expect(name[:middle]).to eq 'E'
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 6 # 2
    end

    it "should parse first initial with period, middle initial with period, last name" do
      name = @np.parse( "M.E. ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "M"
      expect(name[:middle]).to eq 'E.'
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 0 # 3
    end

    it "should parse first initial, two middle initials, last name" do
      name = @np.parse( "M E E  ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "M"
      expect(name[:middle]).to eq 'E E'
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 0 # 4
    end

    it "should parse first initial, two middle initials, last name" do
      name = @np.parse( "M. E. E.  ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "M."
      expect(name[:middle]).to eq 'E. E.'
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 0 # 4
    end

    it "should parse first initial, middle name, last name" do
      name = @np.parse( "M EDWARD ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "M"
      expect(name[:middle]).to eq 'Edward'
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 0 # 5
    end

    it "should parse first name, middle initial, last name" do
      name = @np.parse( "MATTHEW E ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "Matthew"
      expect(name[:middle]).to eq 'E'
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 6
    end

    it "should parse first name, two middle initials, last name" do
      name = @np.parse( "MATTHEW E E ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "Matthew"
      expect(name[:middle]).to eq 'E E'
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 0 # 7
    end

    it "should parse first name, two middle initials with periods without space, last name" do
      name = @np.parse( "MATTHEW E.E. ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "Matthew"
      expect(name[:middle]).to eq 'E.E.'
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 0 # 8
    end

    it "should parse first name, two middle initials with periods, last name" do
      name = @np.parse( "MATTHEW A. B. C. ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "Matthew"
      expect(name[:middle]).to eq 'A. B. C.'
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 0 # 8
    end

    it "should parse first name, last name" do
      name = @np.parse( "MATTHEW ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "Matthew"
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 9
    end

    it "should parse compound first name, last name" do
      name = @np.parse( "MATTHEW-JOSEPH ERICSON-MILLER" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "Matthew-Joseph"
      expect(name[:last]).to eq "Ericson-Miller"
      expect(name[:parse_type]).to eq 9
    end

    it "should parse first name, middle name, last name" do
      name = @np.parse( "MATTHEW EDWARD ERICSON" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "Matthew"
      expect(name[:middle]).to eq 'Edward'
      expect(name[:last]).to eq "Ericson"
      expect(name[:parse_type]).to eq 0 # 10
    end

    it "parses first name, middle initial, middle name, last name" do
      name = @np.parse( "MATTHEW E. SHEIE ERICSON" )
      expect(  name[:parsed]).to be true
      expect(  name[:first]).to eq "Matthew"
      expect(  name[:middle]).to eq 'E. Sheie'
      expect(  name[:last]).to eq "Ericson"
      expect(  name[:parse_type]).to eq 0 # 11
    end

    it "parses first name, middle name, middle initial, last name" do
      name = @np.parse( "MATTHEW ERWIN S. ERICSON" )
      expect(  name[:parsed]).to be true
      expect(  name[:first]).to eq "Matthew"
      expect(  name[:middle]).to eq 'Erwin S.'
      expect(  name[:last]).to eq "Ericson"
      expect(  name[:parse_type]).to eq 0 # 13
    end

    it 'parses two middle names' do
      name = @np.parse( "MATTHEW EDWARD RICHARD ERICSON" )
      expect(  name[:parsed]).to be true
      expect(  name[:first]).to eq "Matthew"
      expect(  name[:middle]).to eq 'Edward Richard'
      expect(  name[:last]).to eq "Ericson"
      expect(  name[:parse_type]).to eq 0 # 11
    end

    it 'parses three middle names' do
      name = @np.parse( "MATTHEW EDWARD RICHARD MARIA ERICSON" )
      expect(  name[:parsed]).to be true
      expect(  name[:first]).to eq "Matthew"
      expect(  name[:middle]).to eq 'Edward Richard Maria'
      expect(  name[:last]).to eq "Ericson"
      expect(  name[:parse_type]).to eq 0 # 11
    end

    it 'parses two middle names and handles compound names' do
      name = @np.parse( "MATTHEW EDWARD RICHARD MARIA-ERICSON" )
      expect(  name[:parsed]).to be true
      expect(  name[:first]).to eq "Matthew"
      expect(  name[:middle]).to eq 'Edward Richard'
      expect(  name[:last]).to eq "Maria-Ericson"
      expect(  name[:parse_type]).to eq 0 # 11
    end

    it 'parses one middle names and handles compound names' do
      name = @np.parse( "MATTHEW HANS-WURST MARIA-ERICSON" )
      expect(  name[:parsed]).to be true
      expect(  name[:first]).to eq "Matthew"
      expect(  name[:middle]).to eq 'Hans-Wurst'
      expect(  name[:last]).to eq "Maria-Ericson"
      expect(  name[:parse_type]).to eq 0 # 10
    end

    it "should parse compound first name, last name" do
      name = @np.parse( "MATTHEW-JOSEPH HANS-WURST ERICSON-MILLER" )
      expect(name[:parsed]).to be true
      expect(name[:first]).to eq "Matthew-Joseph"
      expect(name[:middle]).to eq 'Hans-Wurst'
      expect(name[:last]).to eq "Ericson-Miller"
      expect(name[:parse_type]).to eq 0 # 10
    end

    it 'parses one middle names and handles compound names' do
      name = @np.parse( "HANS-WURST MATTHEW MARIA-ERICSON" )
      expect(  name[:parsed]).to be true
      expect(  name[:first]).to eq 'Hans-Wurst'
      expect(  name[:middle]).to eq "Matthew"
      expect(  name[:last]).to eq "Maria-Ericson"
      expect(  name[:parse_type]).to eq 0 # 10
    end

    it 'parses one middle names and handles compound names' do
      name = @np.parse( "HANS WURST MATTHEW MARIA DE LA CULPA-GARCÍA" )
      expect(  name[:parsed]).to be true
      expect(  name[:last]).to eq "De La Culpa-García"
      expect(  name[:middle]).to eq 'Wurst Matthew Maria'
      expect(  name[:first]).to eq 'Hans'
      expect(  name[:parse_type]).to eq 0
    end
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
      expect(name[:first2]).to eq "Jill"
      expect(name[:parse_type]).to eq 9
    end
=begin
    it "should parse multiple first names and last name with UTF-8 characters" do
      name = @np.parse("MARÍA AND JOSÉ GARCÍA-D'ANGELO" )
      expect(name[:parsed]).to eq true
      expect(name[:multiple]).to be true
      expect(name[:parsed2]).to be true
      expect(name[:first]).to eq 'María'
      expect(name[:first2]).to eq 'José'
      expect(  name[:last]).to eq "García-D'Angelo"
      expect(name[:parse_type]).to eq 9
    end
=end
    it "should parse multiple first names, middle initial, last name" do
      name = @np.parse( "Joe and Jill S Hill" )
      expect(name[:parsed]).to eq true
      expect(name[:multiple]).to be true
      expect(name[:parsed2]).to be true
      expect(name[:parse_type]).to eq 9
      expect(name[:middle2]).to eq 'S'
      expect(name[:first2]).to eq "Jill"
    end

    it "should parse multiple first names, middle initial, last name" do
      name = @np.parse( "Joe S and Jill Hill" )
      expect(name[:parsed]).to eq true
      expect(name[:multiple]).to be true
      expect(name[:parsed2]).to be true
      expect(name[:first2]).to eq "Jill"
      expect(name[:middle]).to eq 'S'
      expect(name[:parse_type]).to eq 6
    end
  end

  describe "Parse unusual names" do
    before( :each ) do
      @np = People::NameParser.new
    end

    it "should parse multiple-word last name" do
      name = @np.parse( "Matthew De La Hoya" )
      expect(name[:parsed]).to be true
      expect(name[:last]).to eq "De La Hoya"
      expect(name[:parse_type]).to eq 9
    end

    it "should parse last name with cammel case" do
      name = @np.parse( "Matthew McIntosh" )
      expect(name[:parsed]).to be true
      expect(name[:last]).to eq "McIntosh"
      expect(name[:parse_type]).to eq 9
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

    it "should parse name with a numerical suffix 1" do
      name = @np.parse( "Matthew E Ericson 1st" )
      expect(name[:parsed]).to be true
      expect(name[:suffix]).to eq "1st"
    end

    it "should parse name with a numerical suffix 2" do
      name = @np.parse( "Matthew E Ericson 2nd" )
      expect(name[:parsed]).to be true
      expect(name[:suffix]).to eq "2nd"
    end

    it "should parse name with a numerical suffix 3" do
      name = @np.parse( "Matthew E Ericson 3rd" )
      expect(name[:parsed]).to be true
      expect(name[:suffix]).to eq "3rd"
    end

    it "should parse name with a numerical suffix 4" do
      name = @np.parse( "Matthew E Ericson 4th" )
      expect(name[:parsed]).to be true
      expect(name[:suffix]).to eq "4th"
    end

    it "should parse name with a numerical suffix 13" do
      name = @np.parse( "Matthew E Ericson 13th" )
      expect(name[:parsed]).to be true
      expect(name[:suffix]).to eq "13th"
    end

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
      expect(name[:title]).to eq "Rabbi "
      expect(name[:first]).to eq 'M'
      expect(name[:parse_type]).to eq 0 # 5
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
