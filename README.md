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

This creates tags as follows.

| **Name**              | **Definition Kind** | **Reference Kind** | **Reference Role** |
|-----------------------|---------------------|--------------------|--------------------|
| Module                | `M`                 | `M`                | `imported`         |
| Datatype              | `d`                 | `t`                | `ref`              |
| Entity                | `E`                 | `t`                | `ref`              |
| Enum                  | `e`                 | `t`                | `ref`              |
| Event                 | `x`                 | `t`                | `ref`              |
| Property              | `p`                 | N/A                | N/A                |
| Structure             | `s`                 | `t`                | `ref`              |
| Union                 | `u`                 | `t`                | `ref`              |
| Member                | `m`                 | N/A                | N/A                |
| Variant               | `V`                 | N/A                | N/A                |
| Annotation Property   | N/A                 | `t`                | `assertion`        |
| Annotation Constraint | `C`                 | N/A                | N/A                |
| *Type*                | `t`                 | `t`                | `imported`         |

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
