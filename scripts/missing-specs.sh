#!/bin/bash

x=`grep -rh 'class.*Controller' app/controllers/ | ruby -ne 'puts $_.split(" ")[1].gsub(/Controller/, "")'`
for file in $x; do rails g rspec:controller $file -s; done

y=`grep -rh '^class' app/models/ | ruby -ne 'puts $_.split(" ")[1]'`
for m in $y; do rails g rspec:model $m -s; done
