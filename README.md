# uHAL Test

Testing the `uhal::ConnectionManager` constructor, namely the function `uhal::utilities::ParseSemicolonDelimitedUriList`


## Use
To use the ready-made image, `docker pull ammitra/uhal_test:latest`

Then, `docker run -it <IMAGE_ID>`

Inside the container, `source entrypoint_env.sh` and run the test executable `./tmp/test/bin/test`. The test code can be modified in:

* `/tmp/test/include/test.hpp` and 
* `/tmp/test/src/common/test.cxx`