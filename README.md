# learningportal

A Couchbase / Elastic Search proof of concept app.

## Development Environment Installation (OSX)

* libcouchbase **1.1.0.dp2**
* couchbase server **2.0** [download](http://packages.couchbase.com/releases/2.0.0-developer-preview-4/couchbase-server-community_x86_64_2.0.0-dev-preview-4.zip)
* elastic search **0.19.2**

### libcouchbase

Download and install this updated `libcouchbase` homebrew recipe.

    wget https://raw.github.com/gist/2694093/e59a2430c9c912e4b8c413f8c19454bb529ba986/libcouchbase.rb -O /usr/local/Library/Formula/libcouchbase.rb

    brew update
    brew install libevent
    brew link libevent
    brew install libcouchbase

### elastic search

    brew install elasticsearch

    plugin -install mobz/elasticsearch-head
    plugin -install elasticsearch/elasticsearch-lang-javascript/1.1.0
    plugin -install mschoch/elasticsearch-river-couchbase/1.0.1-SNAPSHOT



http://karmi.github.com/tire/
https://github.com/karmi/tire

