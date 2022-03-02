#ifndef OBOE_API_HPP
#define OBOE_API_HPP

#include <unistd.h>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <string>
#include <vector>

#include "oboe.h"

class Otel {
    static bool sendEvent(const std::string bson_str, int len);
};

#endif