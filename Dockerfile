FROM composer:1.10

LABEL version="1.0.0"
LABEL repository="https://github.com/php-actions/phpstan"
LABEL homepage="https://github.com/php-actions/phpstan"
LABEL maintainer="Greg Bowler <greg.bowler@g105b.com>"

RUN composer global require --no-progress phpstan/phpstan 0.12.*
COPY entrypoint /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]