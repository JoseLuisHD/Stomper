// This file is part of the Stomper project.
//
// Licensed under the BSD 3-Clause License (the "License"); a copy of the License
// is included with this project. You may also obtain a copy of the License at:
//
//     https://opensource.org/licenses/BSD-3-Clause
//
// Additional licenses for third-party dependencies are also included
// and must be reviewed separately.

#include <catch2/catch_test_macros.hpp>
#include <catch2/internal/catch_preprocessor_internal_stringify.hpp>

#include "catch2/internal/catch_assertion_handler.hpp"
#include "catch2/internal/catch_decomposer.hpp"
#include "catch2/internal/catch_section.hpp"
#include "catch2/internal/catch_test_macro_impl.hpp"
#include "catch2/internal/catch_test_registry.hpp"

int sum(int a, int b) {
    return a + b;
}

TEST_CASE("Test sum function", "[sum]") {
    SECTION("Sum of positive numbers") {
        REQUIRE(sum(2, 3) == 5);
    }
    SECTION("Sum of a positive and a negative number") {
        REQUIRE(sum(5, -2) == 3);
    }
    SECTION("Sum of negative numbers") {
        REQUIRE(sum(-4, -6) == -10);
    }
    SECTION("Sum of a number with zero") {
        REQUIRE(sum(7, 0) == 7);
    }
}
