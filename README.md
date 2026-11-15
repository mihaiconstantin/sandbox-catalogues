# `sandbox` catalogues

This repository contains catalogues for the
[`sandbox`](https://github.com/mihaiconstantin/sandbox) tool. The
[`sandbox`](https://github.com/mihaiconstantin/sandbox) repository includes this
repository as a `git` submodule at `catalogues/`.

## Description

A catalogue defines the recipes that
[`sandbox`](https://github.com/mihaiconstantin/sandbox) uses to build isolated
development boxes from Docker images. Below you can find an overview of the
catalogues (i.e., and their recipes) that are currently available.

### `base` catalogue

|  Recipe  | Extends  | Default | Description                                    |
| :------: | :------: | :-----: | ---------------------------------------------- |
| `ubuntu` |    -     |   yes   | `Ubuntu` 26.04 with various development tools. |
|   `r`    | `ubuntu` |   no    | Adds `R` and the `arf` console.                |
| `latex`  | `ubuntu` |   no    | Adds the full `TeX Live` distribution.         |

## More information

See the [`sandbox` repository](https://github.com/mihaiconstantin/sandbox) or
the [documentation](https://sandbox.mihaiconstantin.com) for more information.

## Contributing

- Any new catalogue contributions or improvements are welcome and greatly
  appreciated. Please open a [pull
  request](https://github.com/mihaiconstantin/sandbox-catalogues/pulls) on
  `GitHub`.

## License

The package source code in this repository is licensed under the [MIT
license](https://opensource.org/license/mit).
