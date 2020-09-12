FROM phpstan/phpstan:0.12

LABEL version="1.0.0"
LABEL repository="https://github.com/php-actions/phpstan"
LABEL homepage="https://github.com/php-actions/phpstan"
LABEL maintainer="Greg Bowler <greg.bowler@g105b.com>"

COPY entrypoint /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]