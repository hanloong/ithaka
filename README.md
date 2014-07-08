Ithaka
=========

[![Build Status](https://api.shippable.com/projects/53bb2e7a3957535502e29590/badge/master)]

## Description

Ithaka is an ideation platform for internal teams and businesses. It promotes innovation from within by enabling users to suggest ideas, share and discuss thoughts and promote transparency in decision making through influence factors. 

## Requirements

- Ruby 2.1.2
- Bundler
- Postgres (optional but prefered)

## Setup

```bash
git clone https://github.com/hanloong/ithaka.git
cd ithaka
bundle install
rake db:create
rake db:migrate
rake db:seed
foreman start
```

## Tests

Using *Rspec 3*

```bash
# run tests
/ithaka/ $ rspec
```

Test coverage is measured after each rspec run and can be fond at ```project_root/coverage/index.html```

## CI and Deployment

Each commit to master will trigger a build on snap-ci and on passing the build will be deployed to ninefold
