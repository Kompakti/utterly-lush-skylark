# Test Design

The most critical scenarios selected for testing were:
- Login
- Purchase flow succeeds with correct data
- User sees the correct product information per product

The scenarios were selected after manually exporing the software under test.

## Keyword and Locator Strategy

Keywords should represent user actions. Sometimes there are more fine-grained keywords than the current test case
requires to support new test cases. An example is to fill out separate fields of a form instead of filling out the
entire form, to support testing validation of individual fields in the future.

Keywords are divided into resources by page. The page resources include locators, which use the css attribute
`data-test` whenever possible.

## Test Data

Test user credentials are stored in `resources/data/users.py`. The password is plain readable in the repository because
the tested site already exposes it. In a real scenario, it could be stored as an environment variable in a local setup
and in a credential storage in the CI.

The product information is stored in products.py.

## Data-driven Strategy

In some test cases, a looping approach is selected instead of using a Robot Framework template. The reasoning behind
this is to keep the data in one place only, under `resources/data`. This makes maintenance easier.

## Internal Test Library

Complicated logic should be placed in a python library. A library called `SauceUtils` is used for miscellaneous utility
keywords. There are still some tests or user keywords that use `Evaluate`, those should be reviewed and possibly moved
to `SauceUtils`.
