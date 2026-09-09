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

Test logs will be available in `output` directory.
