FROM ruby:2.7.2-alpine

RUN apk --update add --no-cache --virtual .dependencies build-base \
 && gem install gm1356 \
 && apk del .dependencies 

CMD ["gm1356"]