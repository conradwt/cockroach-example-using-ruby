# Cockroach Example Using Rails

The purpose of this step by step tutorial is to provide a very simple example of configuring and using Cockroach database engine with the Rails web framework for development.

## Requirements

- [CockroachDB v21.1.9 or newer](https://www.cockroachlabs.com/docs/v21.1/install-cockroachdb.html)

- Libpq 7.2.0 or newer

- Node 14.18.0 or newer

- Rails 6.1.4.1 or newer

- Ruby 3.0.1 or newer

- Yarn 1.22.15 or newer

Note: This tutorial was created using macOS 11.6.

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/cockroachdb). (Tag 'cockroachdb')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/cockroachdb).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation, Setup, and Usage

1.  Open new terminal window

2.  Create node1 of CockroachDB Cluster

    ```zsh
    cockroach start \
    --insecure \
    --store=node1 \
    --listen-addr=localhost:26257 \
    --http-addr=localhost:8080 \
    --join=localhost:26257,localhost:26258,localhost:26259 \
    --background
    ```

3.  Create node2 of CockroachDB Cluster

    ```zsh
    cockroach start \
    --insecure \
    --store=node2 \
    --listen-addr=localhost:26258 \
    --http-addr=localhost:8081 \
    --join=localhost:26257,localhost:26258,localhost:26259 \
    --background
    ```

4.  Create node3 of CockroachDB Cluster

    ```zsh
    cockroach start \
    --insecure \
    --store=node3 \
    --listen-addr=localhost:26259 \
    --http-addr=localhost:8082 \
    --join=localhost:26257,localhost:26258,localhost:26259 \
    --background
    ```

5.  Perform one-time initialization the CockroachDB Cluster

    ```zsh
    cockroach init --insecure --host=localhost:26257
    ```

    Note: One should see the following successful message:

    ```zsh
    Cluster successfully initialized
    ```

6.  Connect to the built-in SQL Client

    ```zsh
    cockroach sql --insecure --host=localhost:26257
    ```

7.  Create the database by entering the following within the console:

    e.g.

    ```zsh
    root@127.0.0.1:26257/defaultdb> CREATE DATABASE cockroach_example_using_rails_development;
    ```

8.  Open another terminal window

9.  Generate a new Rails application

    ```zsh
    rails new cockroach-example-using-rails -d postgresql --skip-active-storage -T --no-rc
    ```

10. Add the ActiveRecord CockroachDB Adapter by doing the following:

    ```zsh
    bundle remove pg
    bundle add activerecord-cockroachdb-adapter
    ```

11. Update the database adapter as follows within `database.yml`:

    replace

    ```yml
    adapter: postgresql
    ```

    with

    ```yml
    adapter: cockroachdb
    ```

12. Add the following after the `pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>` setting within `database.yml`:

    ```yml
    host: <%= ENV.fetch("COCKROACH_HOST") { 'localhost' } %>
    port: <%= ENV.fetch("COCKROACH_PORT") { 26257 } %>
    user: <%= ENV.fetch("COCKROACH_USER") { 'root' } %>
    password: <%= ENV.fetch("COCKROACH_PASSWORD") { 'admin' } %>
    requiressl: true
    ```

13. Generate scaffold of the application

    ```zsh
    rails g scaffold post title body:text
    ```

14. Migrate the database.

    ```zsh
    rails db:migrate
    ```

15. Add the following as the first route within config/routes.rb file:

    ```ruby
    root 'posts#index'
    ```

16. Start the Rails server

    ```
    $ rails s
    ```

17. Play with the application

    ```zsh
    open http://localhost:3000
    ```

18. Cleanu CockroachDB Cluster

    ```zsh
    cockroach quit --insecure --host=localhost:26257
    cockroach quit --insecure --host=localhost:26258
    cockroach quit --insecure --host=localhost:26259
    rm -rf node1 node2 node3
    ```

---

## References

- [CockroachDB](https://www.cockroachlabs.com)

- [Hello World Ruby ActiveRecord](https://github.com/cockroachlabs/hello-world-ruby-activerecord)

- [ActiveRecord CockroachDB Adapter](https://github.com/cockroachdb/activerecord-cockroachdb-adapter)

## Support

Bug reports and feature requests can be filed for the cassandra-example-using-rails project here:

- [File Bug Reports and Features](https://github.com/conradwt/cockroach-example-using-rails/issues)

## Contact

Follow Conrad Taylor on Twitter ([@conradwt](https://twitter.com/conradwt))

## Creator

- [Conrad Taylor](http://github.com/conradwt) ([@conradwt](https://twitter.com/conradwt))

## License

This repository is released under the [MIT License](./LICENSE.md).

## Copyright

&copy; Copyright 2021 Conrad Taylor. All Rights Reserved.
