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
    - uses: php-actions/composer@v2 # or alternative dependency management
    - uses: php-actions/phpstan@v1
    # ... then your own project steps ...
```

Commands
--------

By default, adding - uses: php-actions/phpstan@v1 into your workflow will run `phpstan analyse`, as `analyse` is the default command name.

You can issue custom commands by passing a command input, like so:

```yaml
jobs:
  phpstan:

    ...

    - name: PHPStan
      uses: php-actions/phpstan@v1
      with:
        command: your-command-here
```

Inputs
------

The following configuration options are available:

+ `configuration` Path to the project configuration file
+ `level` Level of rule options - the higher the stricter
+ `paths_file` Path to a file with a list of paths to run analysis on
+ `autoload_file` Project's additional autoload file path
+ `error_format` Format in which to print the result of the analysis
+ `generate_baseline` Path to a file where the baseline should be saved
+ `memory_limit` Memory limit for analysis

The syntax for passing in a custom input is the following:

```yaml
...

jobs:
  phpstan:

    ...

    - name: PHPStan Static Analysis
      uses: php-actions/phpstan@v1
      with:
        configuration: custom/path/to/phpstan.neon
        memory_limit: 256M
```

If you require other configurations of phpstan, please request them in the [Github issue tracker](https://github.com/php-actions/phpstan/issues)

If you found this repository helpful, please consider [sponsoring the developer][sponsor].

[sponsor]: https://github.com/sponsors/g105b
