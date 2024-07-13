# Univeral Ctags SDML Support

This repository contains a configuration file to allow [Universal
Ctags](https://ctags.io/) to create tag files for SDML source.

This allows code navigation in ctags-, or etags,-aware tools such as vim and
Emacs. The following command will create a common `tags` file for all SDML
files, recursively using the `-R` argument. To generate Emacs compatible `ETAGS`
files add the `-e` argument.

```bash
❯ ctags -R *.sdm?
```

By default the command will create *definition* tags only, which is OK as these
are the primary purpose of the tool anyway. If you wish to see references you
need to enable them on the command-line with the following arguments.

```bash
❯ ctags -R --extras=+r --fields=+r *.sdm?
```

This creates tags as follows.

| **Name**              | **Definition Kind** | **Reference Kind** | **Reference Role** | **Notes** |
|-----------------------|---------------------|--------------------|--------------------|-----------|
| Module                | `M`                 | `M`                | `imported`         | 1         |
| Datatype              | `d`                 | `d`, `t`           | `base`, `type`     | 2         |
| Entity                | `E`                 | `E`, `t`           | `source`, `type`   | 3         |
| Enum                  | `e`                 | `t`                | `type`             |           |
| Event                 | `x`                 | `t`                | `type`             |           |
| Property              | `p`                 | `p`                | `ref`              |           |
| Structure             | `s`                 | `t`                | `type`             |           |
| Union                 | `u`                 | `t`                | `type`             |           |
| Member                | `m`                 | N/A                | N/A                |           |
| Variant               | `V`                 | N/A                | N/A                |           |
| Annotation Property   | N/A                 | `t`                | `assertion`        | 4         |
| Annotation Constraint | `C`                 | N/A                | N/A                |           |
| *Type*                | `t`                 | `t`                | `imported`         | 5         |

1. Any unqualified name in an `import` statement is noted as an `imported` module
   reference.
2. Datatypes are required to have a base type, this is noted as a `base`
   datatype reference.
3. Events denote the source that emits them, this is noted as a `source` entity
   reference.
4. The name part of an annotation property is noted as an `assertion` reference.
   If the right-hand side of an annotation property is a qualified name it is
   noted as a `type` reference.
5. Any qualified name in an `import` statement is noted as an `imported` module
   reference.

```sdml
module example is
  ;    ^ M:def

  import dc
  ;      ^ M:imported
  
  import xsd:integer
  ;      ^ t:imported

  @dc:description = "An example"@en
  ;^ t:assertion

  @dc:version =   xsd:decimal(2)
  ;^ t:assertion  ^ t:type
  
  datatype MyInteger <- integer
    ;      ^ d:def      ^ d:base

  property thingIdentifier -> MyInteger
    ;      ^ p:def            ^ t:type

  entity BigThing is
    ;    ^ E:def
    identity ref thingIdentifier
    ;            ^ p:ref

    name -> {0..1} string
    ;^ m:def       ^ t:type
  end

  enum ThingEnum of
    ;  ^ e:def
    ThingOne
    ; ^ V:def
    ThingTwo
    ; ^ V:def
  end
  
  event NewThing source BigThing
    ;   ^ x:def         E:source
  
  structure LittleThing
  ;         ^ s:def
  
  structure OtherThing
  ;         ^ s:def

  union Things of
  ;     ^ u:def
    LittleThing
    ; ^ V:def
    OtherThing as SmallThing
    ;             ^ V:def
  end
  
end
```

## Installation

The file `sdml.ctags` should be copied to, or linked into, the Ctags
configuration directory which can be performed by the shell script `install.sh`.

The easiest way to install is to use the script with no arguments in which case
the file in the same directory will be linked into the configuration directory.
Adding the argument `link` has the same effect.

If you prefer to copy the file, instead of linking, as part of the install add
the `copy` argument.

```bash
❯ ./install.sh
Linking from /home/me/.config/ctags/sdml.ctags to /home/me/gh/sdml-ctags/sdml.ctags
```

To remove the configuration file from the ctags configuration directory the
install script takes a `remove` argument.

```bash
❯ ./install.sh remove
Removing installed file /home/me/.config/ctags/sdml.ctags
```

### Installing Universal Ctags

Detailed installation instructions are in the project's
[Github](https://github.com/universal-ctags/ctags) `README.md` file, but for
macos or Linux these seem to be the most commonly used methods:

```bash
❯ brew install universal-ctags # macos, Linux
❯ sudo snap install universal-ctags # Linux
```

## License

```text
Copyright (c) 2024 Simon Johnston

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## Changes

### Version 0.1.0

* Initial release

## Issues

If you find an issue, please include the following in your report.

1. A minimum working example (MWE), `example.sdml`.
2. The output of the command `ctags --version`.
3. The file `tags` and `ctags.out` generated by the following command.

```bash
❯ ctags --verbose --sort=no example.sdm >ctags.out 2>&1
```

Thank you.
