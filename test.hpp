#include "uhal/uhal.hpp"
#include <string>
#include <vector>
using namespace uhal;

std::string connfile = "file:///opt/address_table/address_apollo.xml";

void test_ConnectionManager() {
        ConnectionManager manager (connfile, std::vector<std::string>(1,"uioaxi-1.0"));
}
