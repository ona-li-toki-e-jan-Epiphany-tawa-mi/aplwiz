# aplwiz

Depedencies:

- GNU APL: ([https://www.gnu.org/software/apl](https://www.gnu.org/software/apl))

There is a `flake.nix` you can use with `nix develop` to generate a development
enviroment.

This project contains a collection of testing script templates, written in GNU
APL, that can be included in your GNU APL projects to add automated testing
(i.e. unit testing, integration testing.)

The scripts *are* templates, so they will require modification to work with your
project. Check the files for instructions.

## unit-tests.apl

Unit testing script. No dependencies.

To run the example tests, run one of the following commands:

```sh
apl --script unit-tests.apl
./unit-tests.apl
```
