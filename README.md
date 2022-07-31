# README.md

This project will help you build a version of `perl` in a Docker
container. You can use that version of `perl` to test a CPAN module.

# Requirements

* `make`
* `docker`

```
usage: make-a-perl.sh options command

Options
-------
-d      name of Dockerfile, default: Dockerfile
-v      version of Perl to build, e.g. 5.10.0
-r      Docker repo to push to
-p      password for docker repo
-l      logfile

Recipes
-------

Build Perl 5.10.10

 $ make-a-perl.sh -v 5.10.0 build

Push to repo

 $ make-a-perl.sh -v 5.10.0 -r ghcr.io/my-repo -p ~/.ssh/github-token push
```

1. Clone the repository

   ```
   git clone https://github.com/rlauer6/make-a-perl.git
   ```
1. Build a version of `perl

   ```
   cd perl
   ./make-a-perl.sh -v 5.16.3 build
   ```
1. Create a CPAN distribution and copy it to `test`

   ```
   cp ~/Amazon-S3-0.55.tar.gz test/
   ```
1. Test the distribution

   ```
   cd test
   VERSION=5.16.3 make test
   ```
