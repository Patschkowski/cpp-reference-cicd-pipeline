from behave import *
import subprocess
import re

@given('no username provided')
def step_impl(context):
  pass

@given('that the user is called "{name}"')
def step_impl(context, name):
  context.name = name

@then('the execution succeeds')
def step_impl(context):
  result = subprocess.run(
    [
      '../out/x64-Debug-MSVC/Debug/hello.exe',
      context.name
    ]
  )
  assert 0 == result.returncode

@then('the greeting will say "Hello, World!"')
def step_impl(context):
  result = subprocess.run(
    [
      '../out/x64-Debug-MSVC/Debug/hello.exe',
      context.name
    ],
    capture_output=True,
    text=True
  )
  assert result.stdout == 'Hello, World!\n'

@then('the execution fails')
def step_impl(context):
  result = subprocess.run([ '../out/x64-Debug-MSVC/Debug/hello.exe' ])
  assert 0 != result.returncode

@then('the output prints the usage')
def step_impl(context):
  result = subprocess.run(
    [ '../out/x64-Debug-MSVC/Debug/hello.exe' ],
    capture_output=True,
    text=True
  )
  assert re.match('^Usage:\ *.*\ <name>$', result.stdout)
