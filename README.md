twitter sfc ikiteru
===================
tweet SFC status


Setup
=====

git clone

    % git clone git://github.com/shokai/twitter_sfc_ikiteru.git


Install Dependencies
--------------------

    % gem install bundler
    % bundle install


Config
------

    % cp sample.config.yaml config.yaml

regist your app [on twitter](http://twitter.com/apps/new)

edit cosumer_key and secret in config.yaml.


get access_token and secret

    % ruby auth.rb


Run
===

    % ruby twitter_sfc_ikiteru.rb
