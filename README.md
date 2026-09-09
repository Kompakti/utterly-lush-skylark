# utterly-lush-skylark

This is a portfolio repository to showcase test automation solutions. The software under test is the web application
running at saucedemo.com.

## Running the tests

Install docker. If your system supports it, follow https://docs.docker.com/engine/install/. Secondary option is to
follow https://docs.docker.com/get-started/get-docker/.

In `utterly-lush-skylark` repository root, run the full test suite:

```
docker run --rm -v $(pwd)/:/tests --user pwuser marketsquare/robotframework-browser:20.4 bash -c "robot --outputdir /tests/output /tests"
```

The shopping flow test case will login with `standard_user` by default, but it can be run as other users by defining an environment variable `SHOPPING_CART_USER`:

```
export SHOPPING_CART_USER=problem_user
docker run --rm -e SHOPPING_CART_USER -v $(pwd)/:/tests --user pwuser marketsquare/robotframework-browser:20.4 bash -c "robot --outputdir /tests/output /tests"
```

Available users are `problem_user`, `performance_glitch_user`, `error_user` and `visual_user`.

Test logs will be available in `output` directory.
