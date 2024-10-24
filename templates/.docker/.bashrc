alias jsd="yarn dev"
alias jsb="yarn prod"
alias ll="ls -lhA --color"

alias pa="php artisan"
alias pakey="php artisan key:generate"
alias pads="php artisan db:seed"
alias pam="php artisan migrate"
alias pamf="php artisan migrate:fresh"
alias pamfs="php artisan migrate:fresh --seed"
alias pamr="php artisan migrate:rollback"
alias parl="php artisan route:list"
alias pat="php artisan test"
alias patf="php artisan test --filter"

alias cop="composer pint"
alias coc="composer check"
alias cos="composer phpstan"
alias coide="composer ide"

alias xdon="export XDEBUG_TRIGGER=1"
alias xdoff="unset XDEBUG_TRIGGER"

LARAVEL_FOLDERS="app bootstrap config database public resources routes storage tests"

alias perf="find ${LARAVEL_FOLDERS} -type f -print0 | xargs -0 chmod g+rw,u+rw,o+rw"
alias perd="find ${LARAVEL_FOLDERS} -type d -print0 | xargs -0 chmod 777"
alias perg="chown -R 1000:www-data ${LARAVEL_FOLDERS}"
alias pera="perf; perd; perg"

