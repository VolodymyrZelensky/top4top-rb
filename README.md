## Ruby Library for [top4top.io](https://top4top.io)
[![Gem Version](https://badge.fury.io/rb/top4top.svg)](https://badge.fury.io/rb/top4top)

## Install

```
 $ gem i top4top
```
or
```bash
git clone https://github.com/Lil-Nickel/top4top-rb.git
cd top4top-rb
gem build top4top.gemspec
gem i top4top-*.gem
```
### requirements
1. Nokogiri *(Html Parse)* : `gem install nokogiri`

## example
```ruby

require 'top4top'
t4t = Top4top.new

unless ARGV[0].nil?
	file = File.absolute_path ARGV[0]
	if t4t.selectFile? file
		response = t4t.Upload # => Array
		puts response  
		# success response :
		#{
		#  :status=>true,
		#  :message=>"تم تحميل الصورة بنجاح",
		#  :results=>[
		#    ["رابط المصغرة",      "[url=https://g.top4top.io/p_2048wvl7o2.png][img]https://g.top4top.io/s_2048wvl7o2.png[/img][/url]"],
		#    ["رابط للمنتديات",      "[url=https://top4top.io/][img]https://g.top4top.io/p_2048wvl7o2.png[/img][/url]"],
		#    ["رابط الصورة المباشر", "https://g.top4top.io/p_2048wvl7o2.png"],
		#    ["رابط الحذف",       "https://top4top.io/del30f945bb82da82983c22cf12bfd79a4b.html"]
		#  ]
		#}
		#
	else
		puts "the file `#{file}` doesn't exist"
		exit 1
	end
end

```
