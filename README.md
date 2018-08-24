# Mocapi


`mocapi` is a simple HTTPd application server which calculates mortgage payment
given schedule and financial details provided by end users.

## Usage

```sh
bundle # install dependencies
bundle exec ./bin/mocapi

# or with ENV variables:
bundle exec ./bin/mocapi APP_ENV=production MAX_MORTGAGE=150_000_99 \
    RATE_UNDER=0.1 RATE_OVER=0.2 # etc...
```

### Environmental Variables

The constants used by `mocapi` to calculate payments and mortgages can be
altered at startup via environmental variables:

| Variable | Default Value | Description |
| --- | --- | --- |
| `APP_ENV` | `'development'` | Sinatra's runmode: `'development'` or `'production'` |
| `RATE_UNDER` | `0.05` | The required rate of downpayment for the portion of a mortgage below `OVERAGE_FLOOR` |
| `RATE_OVER` | `0.10` | The required rate of downpayment for the portion of a mortgage over `OVERAGE_FLOOR` |
| `OVERAGE_FLOOR` | `500_000_00` | The mortgage amount (in cents) above which a downpayment of `RATE_OVER` is required, instead of `RATE_UNDER` |
| `MAX_MORTGAGE` | `1_000_000_00` | The maximum mortgage (in cents) that insurance can be provided for. Mortgages above this limit will require a large enough downpayment or an error will be returned |
| `MORTGAGE_INTEREST` | `0.025` | The default mortgage interest when the application boots. Users may change this value with `PATCH /interest-rate` |

### Routes

#### GET /payment-amount

Get the recurring payment amount of a mortgage (in cents).

| Parameter | Description |
| --- | --- |
| `mortgage` | The total mortgage, in cents |
| `downpayment` | The down payent, in cents |
| `schedule` | The payment schedule. Either `'weekly'`, `'biweekly'`, or `'monthly'`|
| `amortization` | The duration of the mortgage, in whole years |

##### Example cURL

```sh
curl -i -X GET -H "Accept: application/json" \
     -d 'mortgage=10000000&downpayment=2000000&schedule=weekly&amortization=10' \
     'localhost:4567/payment-amount'
```

**Output**

```json
{
  "amount": 15769
}
```

#### GET /mortgage-amount

Get the maximum mortgage amount (in cents).

| Parameter | Description |
| --- | --- |
| `payment` | The payment amount, in cents |
| `downpayment` | An *optional* down payent, in cents |
| `schedule` | The payment schedule. Either `'weekly'`, `'biweekly'`, or `'monthly'`|
| `amortization` | The duration of the mortgage, in whole years |

##### Example cURL

```sh
curl -i -X GET -H "Accept: application/json" \
     -d 'payment=10000&schedule=weekly&amortization=20' \
     'localhost:4567/mortgage-amount'
```

**Output**

```json
{
  "maximum": 10400000
}
```

#### PATCH /interest-rate

Change the interest rate used by the application.

| Parameter | Description |
| --- | --- |
| `payment` | The payment amount, in cents |
| `downpayment` | An *optional* down payent, in cents |
| `schedule` | The payment schedule. Either `'weekly'`, `'biweekly'`, or `'monthly'`|
| `amortization` | The duration of the mortgage, in whole years |

##### Example cURL

```sh
curl -i -X PATCH -H "Accept: application/json" \
     -d 'interest=0.0355' \
     'localhost:4567/interest-rate'
```

**Output**

```json
{
  "old": 0.025,
  "new": 0.0355
}
```

## Development

### Testing

A few Rake commands will help your testing:

  - `bundle exec guard`: Start Red/Green development cycle
  - `rake test`: Run the test suite
  - `rake lint`: Run the code linters
  - `rake simplecov`: Run the code coverage reporter
  - `rake`: Run all tests, linters, and code coverage reporters

To facilitate development, consider running `guard` in the background while you
work. Whenver a source file it changed, it will automatically run the relevent
tests. This will provide you immediate test feedback at all times.

### Documentation

Generate code docs with:

```sh
rake doc
```

### Contributing to Mocapi

  * Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
  * Check out the issue tracker to make sure someone already hasn't requested
    it and/or contributed it.
  * Fork the project.
  * Start a feature/bugfix branch.
  * Commit and push until you are happy with your contribution.
  * Make sure to add tests for it. This is important so I don't break it in a
    future version unintentionally.
  * Please try not to mess with the Rakefile, version, or history. If you want
    to have your own version, or is otherwise necessary, that is fine, but
    please isolate to its own commit so I can cherry-pick around it.
