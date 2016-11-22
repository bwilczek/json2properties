# json2properties

Simple tool that converts JSON files to equivalent content in Java `properties` format. Nested structures are flattened to fit `properties` key-value format.

## Example

Source (`JSON`)
```
{
	"a": 1,
	"b": "two",
	"c": [1, 2, 3],
	"d": {
		"k": 123,
		"l": "asd",
		"m": {
			"types": "hash",
			"and": ["ar", "ra", "y"]
		}
	}
}
```

Destination (`.properties`)

```
a=1
b=two
c.0=1
c.1=2
c.2=3
d.k=123
d.l=asd
d.m.types=hash
d.m.and.0=ar
d.m.and.1=ra
d.m.and.2=y
```

## Usage

### Shell

```
$ gem install json2propeties
$ json2propeties input.json output.properties
```

### Code

```
# Assuming gem has been installed
require 'json2propeties'

converter = Json2properties.new

# Convert file
converter.convert_file('/tmp/input.json', '/tmp/output.properties')

# Convert JSON string to flattened key-value Hash
json = JSON.generate({
	a: 1,
	h: {
		x: 1,
		y: 2
	},
	a: [4, 5, 6]
})
props = converter.json2kv(json)
# props == {
	"a" => 1,
	"h.x" => 1,
	"h.y" => 2,
	"a.0" => 4,
	"a.1" => 5,
	"a.2" => 6,
}
```
