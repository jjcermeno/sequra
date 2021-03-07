This is an exercise according to the problem declared -> [https://gist.github.com/francesc/33239117e4986459a9ff9f6ea64b4e80](https://gist.github.com/francesc/33239117e4986459a9ff9f6ea64b4e80)

# Solution design

## Initial considerations before coding

After reading the proposed exercise I usually start by writing/drawing/mind mapping what I think are the relevant elements involved in the problem, so, I have identified the following facts:

- we need to persist data about merchants, orders and shoppers, this is calling for some organized storing mechanism like a database (I would choose PostgreSQL but SQLite for the exercise will do it too)
- we need to perform some calculation for each order so we can know what is the disbursement based on the fee algorithm
- we would like to use any kind of background job to regularly filter orders and extract our fee per merchant for such period (weekly, on Monday)
- we need to provide an API endpoint to get disbursements for a given week per merchant
- we need data about merchants, shoppers and orders, however, it's not specified how they are reaching our system
- we are dealing with `money`

Exploring the datasets I think I see that some relevant details are:

- fee calculation goes per order and it is yielded by applying a, for the moment, simple algorithm,  and only depends on order's amount, for now, it doesn't depend on specific merchant
- calculating total disbursements per merchant depends on the date that order went completed. Disbursements are per week and per merchant and are calculated weekly
- we need a week number calculator for a given date (coming from order `completed_at`)

Things that are coming to my mind relative to the possible design that I think I can use:

- create a service to import data whenever we want, it could be fired by a worker reading from other API, local file, other database, whatever
- when importing orders we can calculate the disbursement and fee per order so it's already calculated and we can add a `completed` property for faster filtering, same for week number and year
- when retrieving orders to calculate disbursements we should only use those order with `completed` as `true` or `completed_at`as not null and week number and year same as specified period, for the order merchant
- we can have a table for disbursements so we have the merchant, the total disbursement (the total fee and total amount could be useful too), the starting date and ending date for the week or the week number and year, so we have 52-53 rows per merchant per year, tops. (52-53, those are for week based years, weeks starting in Monday)
- we have to take care of calculations with money, so we can use gem `money`

So, once we have identified the key elements in the game, I will try to figure out what is the aspect or behaviour of the final solution and then I will design the diferent elements backwards and then we can go with the implementation starting by the tests. Due to the time limitation, I will design the key software entities I think they will help me reaching the objective.

One good framework I started to take a look at one year and a half ago is [Trailblazer](https://github.com/trailblazer/trailblazer) and [Hanami](https://hanamirb.org/) but I don't have time now for experiments so I will stick with the good old Ruby on Rails.

I think that one of the best ways to use Rails apart from well know resource oriented way is using use-case oriented Rails. This way we can have any feature we want and conveniently decoupled so we can build features based on other features. Furthermore, we can do it in a very verbose way, like plain English, very easy to understand, thus to maintain.

## Designing the solution

### Models identified so far

**`Merchant`**

- id
- merchant_id (that's the id coming from the external API, file or whatever)
- name
- email
- cif

**`Order`**

- id
- order_id (that's the id coming from the external API, file or whatever)
- merchant (will point to `Merchant` model)
- shopper (will point to `Shopper` model)
- disbursement (will point to `Disbursement` model using merchant and time coordinates)
- amount
- fee
- disbursement (equals to amount minus fee)
- created_at
- completed_at
- completed (boolean, default: false, true if completed_at is not empty or not null)
- week (week number of completed_at when it's present)
- year (year number of completed_at when it's present)

**`Shopper`**

- id
- shopper_id (that's the id coming from the external API, file or whatever)
- name
- email

Those are the models inferred from the data, however I think I will use another model to store `disbursements`, so it's pretty easy to query it, adding only 52-53 rows per year per `merchant`, so queries will be lightning fast compared to a query to `Order` model filtering by completed, week number, year and merchant that could be potentially thousands of rows. This way, when creating or updating an order if it is completed then when update the corresponding disbursement row using merchant id, week number and year.

**`Disbursement`**

- id
- merchant (will point to `Merchant` model)
- week
- year
- total_amount (total amount of completed orders for that merchant, week and year)
- total_fee (total fee of completed orders for that merchant, week and year)
- total_disbursement (total disbursement of completed orders for that merchant, week and year)

### Endpoint

For the REST API endpoint:

```
GET /api/v1/disbursements?date={}&id={}
```

where:

- id is the merchant id, optional
- date is any given date to be used to calculate week, optional if not provided previous week to current date will be used

Response:

```
{
 "id": 1,
 "name": "Merchant 1"
 "week": 9,
 "year": 2021,
 "total_disbursement": ,
 "total_amount": ,
 "total_fee":
}
```

In case no merchant is specified, we should return all merchants, but entering week is mandatory or will be asume previous week to current day, so response will be an array:

```
[
    {
        "id": 1,
        "name": "Merchant 1"
        "week": 9,
        "year": 2021,
        "total_disbursement": ,
        "total_amount": ,
        "total_fee":
    },
    {
        "id": 2,
        "name": "Merchant 2"
        "week": 9,
        "year": 2021,
        "total_disbursement": ,
        "total_amount": ,
        "total_fee":
    },
    ...
]
```

In theory, we can use the last reponse (array) even with only one result.

### Other elements

To render this response we can use a Rails `Presenter`. This `Disbursement Presenter` will be the result of a `Repository` query and then we can change properties if necessary.

The `Repository` will be populated with disbursements every time a job runs. This job will use a `Service Object`, `Interactor`, `Command`, `Use Case` or whatever the name you want to use. This service/command/interactor/concept/use case will be responsible of orchestrating the different actions in order to arrange the disbursements for each merchant considering the `completed` status and week it belongs to.

Other helper services could be the `CalculateFee` and `GetWeekAndYearFromDate` that will allow to calculate fee given an amount and returning the week number and year for a week based year starting on Monday, respectively.

Tests will be created for every use case (the one used by the endpoint controller and the other used by the background job, the helper services and the presenter, at least the one used by the use case triggered by reaching the REST API endpoint.

## Implementing the solution

### Main Elements of the solution

I will implement different software elements in this order, from tiny or simplest elements to most complex. Additional elements could be needed and added then.

I have used Rails v6, PostgreSQL for data persitance, sidekiq and Redis for background jobs (Redis for in-memory database to schedule jobs)

**Presenters**
I usually use a base presenter and a collection presenter that is just an array of that base presenter. Additionally I use complete detailed  presenters and simple presenters depending on the desired response.
I will create presenter for a disbursement with all orders (simple mode) and a presenter with disbursements with no orders.

**Services**
I will create at least to services: CalculateFee, that will return fee according to the algorithm depending on amount of orders, and GetWeekAndYear from a given date. It will return a hash with week number and year number for a week based year.

**Repositories**
I will create repositories for every entity we need to get, save, update or delete. So, we will have repos for:

- Merchants
- Orders
- Shoppers
- Disbursements

**Use cases**
Use cases are where the business logic lives. At least, I will create a use case for getting disbursements (GetDisbursements), to be used by the API endpoint, and LoadOrders, that will read orders data and process that data accordingly.

Steps for use cases could be:
GetDisbursements

+ get week, default: previous week to current day
+ get merchant, default: all merchants
+ Ask to disbursement repo where:
+ + merchant Id if any
+ + week number and year
+ With the disbursements list (at least an array of one if merchant is valid), create data with disbursement presenter.

ResetDisbursements

+ get merchants fro repo
+ For each merchant set rows to zero (total_amount, total_fee, total_disbursement) or just

LoadOrders

+ load CSV or json files
+ Loop over elements
+ Get order and identify Id, merchant, Amount, completed_at, week and year and fees
+ If completed, update corresponding disbursement

For each software element I will write first some tests. For example:

- for services

  - CalculateFee, I will test for each range of the algorithm

  - GetWeekAndYear, I will test calculation for a given date and other with no given date

- for use cases

  - GetDisbursements:

    - get list of specific week and merchant (happy path)

    - get list of specific week and no merchant

    - get list with no date and specific merchant

    - get list with no date and no merchant

  - ResetDisbursements, set Disbursement table to zero for each merchant.

  - LoadOrders, this one will be called by the background job scheduled to run every Monday

# Using the solution

Download the repo to the machine you want to use. You'll find one main folder, `sequra`  and inside you will find a folder called `sequra_api`, a `docker-compose.yml` file, a `Makefile` file and this [`README.md`](http://readme.md) file.

The `Makefile` it's very useful as I introduced there complex or very frequently used commands.

The first procedure is to install and deploy so:

- open a terminal and go to folder `sequra`

- using the terminal type:

    start the docker service (in Linux) if it's not started

```bash
make docker-start
```

- then just build all the system

```bash
make docker-build
```

- it will install all needed software, including Ruby, Ruby on Rails, postgres and sidekiq
- Now, we have to create and migrate databases in Rails so

```bash
make db-create
# and after that
make db-migrate
```

- To launch the tests do

```bash
make tests
# or
make rspec
```

- With the tests I had some issues when dealing with ids when using factories to create objects (I am a little bit rusty), I think I solve them but in case they appear just run the tests again, it's probably they don't appear now
- To run the solution just do

```bash
make docker-up
# or
make docker-upd
```

- the last command is for detached servers, but I prefer the first one, I like taking a look at the output. In case you want stop server with the first command just press Ctrl+C. In case of the second command, use this one:

```bash
make docker-down
```

Those are the exposed ports:

- 3030 for Ruby on Rails
- 5432 for PostgreSQL
- 6379 for Redis

So, when servers are running just to [http://localhost:3030](http://localhost:3030) in any REST API Client and enjoy the solution. That's all.

## What is left behind

I had to take some decisions about what not to cover and what is not included. It is intentionally not included:

+ any authentication and authorization mechanisms, system is for now, open to anyone. It is a big subject and it out of the exercise

+ any auditing, exporting to external services like spreadsheets, Airtable-like services or any other dashboard systems

I decided to make queries as simple as possible and save in database all possible data so queries are debugable, easy and quick. Of course, using advanced queries there is no need to use a table like `Disbursements` but it makes the system less maintenable.
