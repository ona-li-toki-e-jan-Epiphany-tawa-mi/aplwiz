#!/usr/local/bin/apl --script

⍝ This file is part of aplwiz.
⍝
⍝ Copyright (c) 2024 ona-li-toki-e-jan-Epiphany-tawa-mi
⍝
⍝ aplwiz is free software: you can redistribute it and/or modify it under the
⍝ terms of the GNU General Public License as published by the Free Software
⍝ Foundation, either version 3 of the License, or (at your option) any later
⍝ version.
⍝
⍝ aplwiz is distributed in the hope that it will be useful, but WITHOUT ANY
⍝ WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
⍝ A PARTICULAR PURPOSE. See the GNU General Public License for more details.
⍝
⍝ You should have received a copy of the GNU General Public License along with
⍝ aplwiz. If not, see <https://www.gnu.org/licenses/>..

⍝ aplwiz GNU APL unit testing script template.
⍝ See the TODOs for how to use.

⍝ Original source:
⍝ - paltepuk - https://http://paltepuk.xyz/cgit/aplwiz.git/about/
⍝ - paltepuk (I2P) - http://oytjumugnwsf4g72vemtamo72vfvgmp4lfsf6wmggcvba3qmcsta.b32.i2p/cgit/aplwiz.git/about/
⍝ - paltepuk (Tor) - http://4blcq4arxhbkc77tfrtmy4pptf55gjbhlj32rbfyskl672v2plsmjcyd.onion/cgit/aplwiz.git/about/
⍝ - GitHub - https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/aplwiz/

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Testing Functions                                                            ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ The number of tests called with RUN.
TEST_COUNT←0
⍝ Whether the current test with RUN failed.
TEST_FAILED←0
⍝ The section name to display for failed assertions. ⍬ means no section.
SECTION_NAME←⍬
⍝ Counter.
ASSERTION_NUMBER←0
FAILED_TESTS←⍬

⍝ Runs the given test. Must be used to call functions with SECTION and ASSERT.
⍝ TEST: string - the test function to run.
∇RUN TEST; RESULT
  TEST_COUNT←1+TEST_COUNT

  TEST_FAILED←0
  SECTION_NAME←⍬
  ASSERTION_NUMBER←0
  ⍞←"Runnning test '" ◊ ⍞←TEST ◊ ⍞←"'... "
  ⍎TEST

  →TEST_FAILED ⍴ LFAILED
    ⍞←"OK\n" ◊ →LNOT_FAILED
  LFAILED:
    ⍞←"FAIL\n"
    →(0≢≢SECTION_NAME) ⍴ LHAS_SECTION_NAME
      FAILED_TESTS←FAILED_TESTS,⊂TEST," assertion",ASSERTION_NUMBER
      →LNO_SECTION_NAME
    LHAS_SECTION_NAME:
      FAILED_TESTS←FAILED_TESTS,⊂TEST," section '",SECTION_NAME,"' assertion",ASSERTION_NUMBER
    LNO_SECTION_NAME:
  LNOT_FAILED:
∇

⍝ Sets the current section name, which is displayed when assertions faile.
⍝ NAME: string.
∇SECTION NAME
  SECTION_NAME←NAME
  ASSERTION_NUMBER←0
∇

⍝ Asserts that RESULT is true.
⍝ RESULT: boolean.
⍝ FAILED: boolean - opposite of RESULT.
∇FAILED←ASSERT RESULT
  →(0≡RESULT) ⍴ LVALID ◊ →(1≡RESULT) ⍴ LVALID
    ⍞←"\nASSERT: encounted unexpected result value. Expected a scalar 0 or 1, got"
    ⍞←": '" ◊ ⍞←RESULT ◊ ⍞←"'\n"
    ⍎")OFF 1"
  LVALID:

  ASSERTION_NUMBER←1+ASSERTION_NUMBER

  →TEST_FAILED ⍴ LALREADY_FAILED
  TEST_FAILED←~RESULT
LALREADY_FAILED:
  FAILED←TEST_FAILED
∇

⍝ Macro for asserting a value in RESULT.
ASSERT_R←"→(ASSERT RESULT) ⍴ LFAIL"

⍝ Prints out the final report for the tests.
∇REPORT; TESTS_PASSED
  TESTS_PASSED←TEST_COUNT-≢FAILED_TESTS
  ⍞←TESTS_PASSED ◊ ⍞←"/" ◊ ⍞←TEST_COUNT ◊ ⍞←" test(s) passed - "
  →(0≢≢FAILED_TESTS) ⍴ LTESTS_FAILED
    ⍞←"OK\n" ◊ →LTESTS_PASSED
  LTESTS_FAILED:
    ⍞←"FAIL\n"
    ⍞←"\nPlease review the following failed tests:\n"
    REPORT_TEST_FAILED¨ FAILED_TESTS
  LTESTS_PASSED:
∇
∇REPORT_TEST_FAILED TEST_NAME
  ⍞←" - " ◊ ⍞←TEST_NAME ◊ ⍞←"\n"
∇

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Tests                                                                        ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ TODO create your own tests.
∇TEST_EXAMPLE; RESULT
  SECTION "Passing tests"
  RESULT←1≡1                            ◊ ⍎ASSERT_R
  RESULT←1 2 3≡⍳3                       ◊ ⍎ASSERT_R
  RESULT←"hello world"≡"hello ","world" ◊ ⍎ASSERT_R

  SECTION "Failing test"
  RESULT←1≡0 ◊ ⍎ASSERT_R

LFAIL:
∇

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Test Runner                                                                  ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ TODO uncomment and replace <file> with the file of your APL code to test.
⍝⊣ ⍎")COPY <file>"

∇MAIN
  ⍝ TODO run your custom tests here.
  RUN "TEST_EXAMPLE"
  ⍞←"\n" ◊ REPORT

  →(0≡≢FAILED_TESTS) ⍴ LSUCCESS
    ⍎")OFF 1"
  LSUCCESS:
∇
MAIN

)OFF
