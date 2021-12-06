<img src="http://159.65.210.101/php-actions.png" align="right" alt="PHP Static Analysis in Github Actions" />

 PHP Static Analysis in Github Actions. 
 ======================================

PHPStan finds bugs in your code without writing tests by using runnin static analysis on your project's code.

Usage
-----

Create your Github Workflow configuration in `.github/workflows/ci.yml` or similar.

```yaml
name: CI

on: [push]

jobs:
  build-test:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - uses: php-actions/composer@v6 # or alternative dependency management
    - uses: php-actions/phpstan@v3
    # ... then your own project steps ...
```

### Version numbers

This action is released with semantic version numbers, but also tagged so the latest major release's tag always points to the latest release within the matching major version.

Please feel free to use `uses: php-actions/phpstan@v3` to always run the latest version of v3, or `uses: php-actions/phpstan@v3.0.0` to specify the exact release.

Example
-------

We've put together an extremely simple example application that uses `php-actions/phpstan`. Check it out here: https://github.com/php-actions/example-phpstan.

Inputs
------

The following configuration options are available:

+ `version` The version of PHPUnit to use e.g. `9` or `9.5.0` (default: latest)
+ `php_version` The version of PHP to use e.g. `7.4` (default: latest)
+ `php_extensions` Space-separated list of extensions using [php-build][php-build] e.g. `xdebug mbstring` (default: N/A)
+ `command` The command to run e.g. `list` or `worker` (default: analyse)
+ `path` Path(s) with source code to run analysis on (required)
+ `configuration` Configuration file location
+ `level` Level of rule options - the higher, the stricter
+ `paths_file` Path to a file with a list of paths to run analysis on
+ `autoload_file` Project's additional autoload file path
+ `error_format` Format in which to print the result of the analysis
+ `generate_baseline` Path to a file where the baseline should be saved
+ `memory_limit` Memory limit for analysis
+ `args` Extra arguments to pass to the phpstan binary

By default, adding - uses: php-actions/phpstan@v2 into your workflow will run `phpstan analyse`, as `analyse` is the default command name.

You can issue custom commands by passing a command input, like so:

```yaml
jobs:
  phpstan:

    ...

    - name: PHPStan
      uses: php-actions/phpstan@v2
      with:
        command: your-command-here
```

The syntax for passing in a custom input is the following:

```yaml
...

jobs:
  phpstan:

    ...

    - name: PHPStan Static Analysis
      uses: php-actions/phpstan@v2
      with:
        configuration: custom/path/to/phpstan.neon
        memory_limit: 256M
```

If you require other configurations of phpstan, please request them in the [Github issue tracker](https://github.com/php-actions/phpstan/issues)

PHP and PHPStan versions
------------------------

It's possible to run any version of PHPStan under any version of PHP, with any PHP extensions you require. This is configured with the following inputs:

+ `version` - the version number of PHPStan to run e.g. `0.12.63` (default: latest)
+ `php_version` - the version number of PHP to use e.g. `7.4` (default: latest)
+ `php_extensions` - a space-separated list of extensions to install using [php-build][php-build] e.g. `xdebug mbstring` (default: N/A)

If you require a specific version combination that is not compatible with Github Actions for some reason, please make a request in the [Github issue tracker][issues].


***

If you found this repository helpful, please consider [sponsoring the developer][sponsor].

[php-build]: https://github.com/php-actions/php-build
[issues]: https://github.com/php-actions/phpstan/issues
[sponsor]: https://github.com/sponsors/g105b
