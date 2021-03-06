
# NOTE: The [original author no longer maintains the people gem](https://github.com/mericson/people)

# Use this Fork at your own risk

-----

# People

This Gem parses names into parts. Loosely based on the Lingua-EN-NameParser Perl module.

## How to install

```
  sudo gem install people
```

## How to use

```
  require 'people'

  np = People::NameParser.new

  name = np.parse( "Matthew E Ericson" )
  puts name[:parsed]
  puts name[:orig]
  puts name[:first]
  puts name[:last]
```

If name successfully parses, `name[:parsed]` is set to true.

Available parts are `:title, :first, :middle, :last, :suffix, :first2, :middle2, :title2, :suffix2, :orig, :match_type`

By default, it will try to proper case names. If you want to leave the capitalization alone, pass `:case_mode => 'leave'` or for uppercase, `'upper'`.

```
  np = People::NameParser.new( :case_mode => 'proper' )
  np = People::NameParser.new( :case_mode => 'leave' )
  np = People::NameParser.new( :case_mode => 'upper' )
```

If you have names like "John and Jane Doe", pass `:couples => true`

```
  np = People::NameParser.new( :couples => true, :case_mode => 'upper' )

  name = np.parse( "John and Jane Doe" )
  puts name[:first]
  puts name[:first2]
  puts name[:last]
```

Try it out online at http://people.ericson.net

Send suggestions to mericson at ericson dot net.


# Copyright

Copyright (c) 2009 Matthew Ericson. See [LICENSE](https://github.com/1debit/people/blob/master/LICENSE) for details.
