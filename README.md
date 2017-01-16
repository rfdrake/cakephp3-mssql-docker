This Dockerfile builds a cakephp3 environment with the MSSQL drivers from
Microsoft.  It also includes sqlite3, Postgres and MySQL because you might
need to access multiple database types from your application.

Instructions:

1. docker build -t cakephp .
2. docker run -v $PWD:/home/web -it cakephp composer create-project --prefer-dist cakephp/app testing
3. edit testing/config/app.php and change the database driver..
4. docker run -v $PWD:/home/web -p 8765:8765 -it cakephp testing/bin/cake server -H 0.0.0.0

If you want migrations (or want to install other plugins):

5. docker run -v $PWD:/home/web -p 8765:8765 -it cakephp bash -c 'cd /home/web/testing; cakephp composer require cakephp/migrations "@stable"'
