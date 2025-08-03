# CheapCoder

The **CheapCoder** gem can censor Ruby scripts.

This allows only non-structed scripts which do not contain any shell command.

## Usage

The sample code below provides a script [samples/sample1.rb](https://github.com/daiji-tsutsui/cheap_coder/blob/develop/samples/sample1.rb) rejected any built-in methods, *e.g.* `puts` and `==` (received by a constant).
```ruby
require 'cheap_coder'
require 'parser/current'

CODEPATH = 'samples/sample1.rb'

expr = Parser::CurrentRuby.parse(File.read(CODEPATH))
censor = CheapCoder::Censor.new
expr = censor.process(expr)
puts Unparser.unparse(expr)
```

The censor rejects also any shell commands.
For example, please see the censord result of [samples/sample2.rb](https://github.com/daiji-tsutsui/cheap_coder/blob/develop/samples/sample1.rb).

### Whitelist
One can set a whitelist of methods.
The sample below provides a script admits the build-in `puts`.
```ruby
method_whitelist = %i[puts]
censor = CheapCoder::Censor.new(
  allowed_methods: method_whitelist,
)
expr = censor.process(expr)
```

### Evaluator
One can set an evaluator to a censor instance.
For example, the below evaluates the [ABC size metric](https://wiki.c2.com/?AbcMetric) (not strictly).
```ruby
censor = CheapCoder::Censor.new(
  evaluator: CheapCoder::AbcEvaluator.new
)
censor.process(expr)
censor.score # gives ABC size
```
