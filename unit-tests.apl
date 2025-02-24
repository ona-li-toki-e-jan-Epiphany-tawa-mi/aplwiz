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
⍝ aplwiz. If not, see <https://www.gnu.org/licenses/>.

⍝ Original source:
⍝ - paltepuk - https://http://paltepuk.xyz/cgit/aplwiz.git/about/
⍝ - paltepuk (I2P) - http://oytjumugnwsf4g72vemtamo72vfvgmp4lfsf6wmggcvba3qmcsta.b32.i2p/cgit/aplwiz.git/about/
⍝ - paltepuk (Tor) - http://4blcq4arxhbkc77tfrtmy4pptf55gjbhlj32rbfyskl672v2plsmjcyd.onion/cgit/aplwiz.git/about/
⍝ - GitHub - https://github.com/ona-li-toki-e-jan-Epiphany-tawa-mi/aplwiz/

⍝ aplwiz GNU APL unit testing script template.
⍝ See the TODOs for how to use.

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Testing Functions                                                            ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ The number of tests called with RUN.
test_count←0
⍝ Whether the current test with RUN failed.
test_failed←0
⍝ The section name to display for failed assertions. ⍬ means no section.
section_name←⍬
⍝ Counters.
assertion_number←0
failed_tests←⍬

⍝ Runs the given test. Must be used to call functions with SECTION and ASSERT.
⍝ →test: string - the test function to run.
∇RUN test; result
  test_count←1+test_count

  test_failed←0
  section_name←⍬
  assertion_number←0
  ⍞←"Runnning test '" ◊ ⍞←test ◊ ⍞←"'... "
  ⍎test

  →test_failed ⍴ lfailed
    ⍞←"OK\n" ◊ →lnot_failed
  lfailed:
    ⍞←"FAIL\n"
    →(0≢≢section_name) ⍴ lhas_section_name
      failed_tests←failed_tests,⊂test," assertion",assertion_number
      →lno_section_name
    lhas_section_name:
      failed_tests←failed_tests,⊂test," section '",section_name,"' assertion",assertion_number
    lno_section_name:
  lnot_failed:
∇

⍝ Sets the current section name, which is displayed when assertions fail.
⍝ →name: string.
∇SECTION name
  section_name←name
  assertion_number←0
∇

⍝ Asserts that result is true.
⍝ →result: boolean.
⍝ ←failed: boolean - opposite of result.
∇failed←ASSERT result
  →(0≡result) ⍴ lvalid ◊ →(1≡result) ⍴ lvalid
    ⍞←"\nASSERT: encounted unexpected result value. Expected a scalar 0 or 1, got"
    ⍞←": '" ◊ ⍞←result ◊ ⍞←"'\n"
    ⍎")OFF 1"
  lvalid:

  assertion_number←1+assertion_number

  →test_failed ⍴ lalready_failed
  test_failed←~result
lalready_failed:
  failed←test_failed
∇

⍝ Macro for asserting a value in result.
⍝ Type: string.
massert←"→(ASSERT result) ⍴ lfail"

⍝ Prints out the final report for the tests.
∇REPORT; tests_passed
  tests_passed←test_count-≢failed_tests
  ⍞←tests_passed ◊ ⍞←"/" ◊ ⍞←test_count ◊ ⍞←" test(s) passed - "
  →(0≢≢failed_tests) ⍴ ltests_failed
    ⍞←"OK\n" ◊ →ltests_passed
  ltests_failed:
    ⍞←"FAIL\n"
    ⍞←"\nPlease review the following failed tests:\n"
    REPORT_TEST_FAILED¨ failed_tests
  ltests_passed:
∇
∇REPORT_TEST_FAILED test_name
  ⍞←" - " ◊ ⍞←test_name ◊ ⍞←"\n"
∇

⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝
⍝ Tests                                                                        ⍝
⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

⍝ TODO create your own tests.
∇TEST_EXAMPLE; result
  SECTION "Passing tests"
  result←1≡1                            ◊ ⍎massert
  result←1 2 3≡⍳3                       ◊ ⍎massert
  result←"hello world"≡"hello ","world" ◊ ⍎massert

  SECTION "Failing test"
  result←1≡0 ◊ ⍎massert

lfail:
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

  →(0≡≢failed_tests) ⍴ lsuccess
    ⍎")OFF 1"
  lsuccess:
∇
MAIN

)OFF
