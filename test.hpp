#include "uhal/uhal.hpp"
#include <string>
#include <vector>
#include <stdio.h>
using namespace uhal;

std::string prefix = "file://";
std::string connFile = "/opt/address_tables/connections.xml";

void test_ConnectionManager() {
        printf("Passing: %s to ConnectionManager constructor\n",(prefix+connFile).c_str());
        ConnectionManager manager ((prefix+connFile), std::vector<std::string>(1,"uioaxi-1.0"));
}
