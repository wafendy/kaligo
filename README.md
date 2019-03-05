# Kaligo

## Getting Started

Simply run the following commands to get started.
```
bundle install

rake db:setup
rake db:migrate
```

Execute one of the following commands to import the supplier data into local db. Data should be sanitized per supplier.

```
rake suppliers:import:all           # Import all suppliers data API
rake suppliers:import:supplier_1    # Import all Supplier 1 data API
rake suppliers:import:supplier_2    # Import all Supplier 2 data API
rake suppliers:import:supplier_3    # Import all Supplier 3 data API
```

## Reasoning

Aggregating data on the fly can be really slow and bad for User Experience and can really hurt the SEO performance. Therefore I chose to save the aggregated(processed) data in the single DB.

I chose PosgreSQL because `pg` support columns as array, can be use for faster querying.

## Importing Supplier's Data
Assuming that the suppliers' data will not change very often, it's ok to run the `rake task` every day in the early morning by setting up `cronjob` or `whenever` gem.

## Processing Supplier's Data
I would like to give [kiba](https://github.com/thbar/kiba) gem a try. FYI, This is not my domain expert. To speed up the data processing time, we could even code the ETL in high performing languages such as Elixir or maybe GoLang.

## Fast JSON API

I've been using [fast_jsonapi](https://github.com/Netflix/fast_jsonapi) as a standard format to build simple API services. Attributes and relationships can be selectively returned per record type by using the `fields` option. This can minimize the download size if you want to serve mobile users with slow internet connection because there are cases where you don't need to download everything when listing the hotels. More details information can be retrieved later if users decided to see more details about particular hotel.

## ActiveRecord Import

[activerecord-import](https://github.com/zdennis/activerecord-import) is a library for bulk inserting data using ActiveRecord. One of its major features is following activerecord associations and generating the minimal number of SQL insert statements required, avoiding the N+1 insert problem

## FrontEnd App

For good SEO performance, Google prefers ServerSide rendering instead of having our application calling ajax to retrieve and to render the data. SEO Robot will not wait very long for ajax requests to be done. For this reason I would suggest building the front-end app using either Nuxt, Next, Rails with CloudFlare caching. This will give you the best overall performance. Cache can be invalidated whenever `rake tasks` completed all the tasks.

Do not rely on jQuery. If FE is built in Vue, we can drop jQuery. Combining them both resulting in a bloated app (Vue 40KB + jQuery 30 KB). If jQuery is a must, consider using [Cash (only 4KB)](https://github.com/kenwheeler/cash)

Split the css into `above the fold` and `below the fold`, move all javascripts to the bottom of body, include critical css, apply lazy loading on all images (except the above the fold image). Lastly ensure the app has proper meta tags, og tags, structured google data, to increase `organic` traffic and to save money on paid advertisements.

## Other Improvements

There are many other improvements which could be done:

1. The intellegince to better assimilate data from supplier. For example `Hotel Shinjuku Tokyo` vs `Tokyo Hotel Shinjuku`
2. Checking for valid image url and exclude invalid images.
3. Apply URL shortener strategy (i.e. http://kaligo.url/UXbT1LSa) for all incoming urls (including images).
4. Array values, detecting similar or duplicate array value in Booking Conditions
5. Standardising the amenities keywords (i.e. `pool` can be mapped to `outdoor pool`, `BathTub` can be replaced with `Bathtub`, etc)
6. Use `CloudFront` for maximum performance and availability.
