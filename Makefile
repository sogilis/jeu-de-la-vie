src/catch.hpp:
	@echo "  CURL  $@"
	curl -Ls -o $@ https://raw.github.com/philsquared/Catch/master/single_include/catch.hpp

include linkopts/gendeps.make
include src/main.D
include src/tests.D

clean:
	rm -f src/*.D src/*.o
