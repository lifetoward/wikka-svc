# Setting up **wikka-svc** #

This is a docker container specification to produce a WikkaWiki service instance.

It's based on the lovely PHP base `caddy/caddy` foundation, adding WikkaWiki as its web application.

## How do I get set up? 

`git clone git@bitbucket.org:lifetoward/wikka-svc.git`

`docker build --build-arg enable_telemetry=false wikka-svc`

`docker run -d -P --name mywikka wikka-svc`

## Design notes

Our approach here is to put the latest version of **WikkaWiki** (1.4 as of this writing) into `/srv` (the caddy container's *application* directory) and maintain the page data in the **SQLite** database file mounted into the container at `/mnt/wikka.sqlite`. 

Additional information about this instance, drawn in through environment variables, will be pulled from that same data directory via `/mnt/env.sh`. Good examples include:

* DOMAIN - The domain on which we're hosting the wiki
* URI - Location through which to represent the wiki (initially `/wiki/`)

Static content can be provided in `/mnt/static`, but we preconfigure a redirector to the `/wiki/` URI.

As per the foundation container specification, `caddy` v2 and `sqlite` v3 are installed generally in the container with `php` v7 enabled through fastcgi.

## Maintained by 

* Guy Johnson <Dev@SyntheticWebApps.com>