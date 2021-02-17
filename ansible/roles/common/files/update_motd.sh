#!/bin/bash
echo "$(tput setaf 2)
   .~~.   .~~.
  '. \ ' ' / .'$(tput setaf 1)
   .~ .~~~..~.
  : .~.'~'.~. :
 ~ (   ) (   ) ~
( : '~'.~.'~' : ) $(tput sgr0)Welcome to the lab cluster: $(tput setaf 3)`hostname -s`$(tput setaf 1)
 ~ .~ (   ) ~. ~
  (  : '~' :  )
   '~ .~~~. ~'
       '~'
$(tput sgr0)"
