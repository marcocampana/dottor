Dottor
======

Description
-----------
Dottor is an unobtrusive command line tool for easily managing your dotfiles,
without assumptions on how your dotfiles repository should be organized.

Why Dottor?
-----------
I designed dottor so that it would be easy to setup and use, reliable and work
with existing dotfiles repos.

With Dottor you can:

1. Get started with yout current dotfils repo, without changing anything.
2. Specify different profiles, so that you can use it to symlink files in your
dev machine as well as in your production boxes.

How it works?
-------------

Dottor expect to find in your repo a YAML file named dottor_rules.yml (or you
can specify a different path) with the following format

```ruby
  profile_name:
  -  source: <dotffile or directory>
     target: <where do you want the file to be symlinked to>
  -  source: <dotffile or directory>
     target: <where do you want the file to be symlinked to>
```

All the actions performed by Dottor are based on the dottor_rules.yml file.
Check my [dotfiles repo][dotfiles_repo] for a working example.


Getting started
---------------

```
  gem install dottor
```

### Create a dottor_rules.yml inside your dotfiles repo

```
  dottor init
```

### Create symlinks based on dottor_rules.yml file in current directory

```
  dottor symlink <profile_name>
```

### Specify a dottor_rules.yml file in another directory

```
  dottor symlink <profile_name> -f <custom_path>
```

### Delete all the symlinks

```
  dottor symlink -d
```

Submitting a Pull Request
-------------------------

1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
6. Add specs for your feature or bug fix.
8. Commit and push your changes.

License
-------
Released under the MIT License.  See the [LICENSE][license] file for further
details.

[license]: https://github.com/marcocampana/dottor/blob/master/LICENSE.md
[dotfiles_repo]: https://github.com/marcocampana/dotfiles
