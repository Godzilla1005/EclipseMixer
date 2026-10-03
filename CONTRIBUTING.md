# Contribution Guidelines
Thank you for being interested in contributing to the project! While simple in scope, I want this program to be safe and easy to use for anyone who wants an easy way to dynamically manage audio files. 

## Merging
When making a pull request, please do not try to merge any large features that deviate from the stated purpose of the program. Optimizations, safety tweaks, graphical updates, and other simple changes are appreciated, but features unrelated to the program's function as an audio mixer are not wanted.
As for the content of contributions, please do not merge fully AI-generated code. I would prefer to maintain a codebase that is written and maintained by humans who are familiar with their contributions and the rationale behind it.

## Style
Please comment all code you contribute! This project uses static typing for all variables (Variant if dynamic) and tabs for indents.
Please defer to the official [GDScript style guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html), along with the following pattern for commenting:
```
### Authored by Class Author, Edits by Contributors
### Class description
class_name PascalCase extends Parent

signal signal_name(parameter: type) ## Signal description

## Enum description
enum PascalCase {
  ONE,
  TWO,
  THREE,
}

## Field Header
var var_name: type # in-line description and default values are optional


## Function header with brief description
func foo() -> type:
  ## body comments for blocks
  var_name.function() # in-line comments for line

  return var_name # description of result
```
