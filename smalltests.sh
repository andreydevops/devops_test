#!/bin/bash
url="http://localhost:8080"
requests="/ /88 /admin /"

echo "---- URI TESTING START----"
for var in ${requests}
do
  echo "======"
  echo "Request to $url$var"
  echo "Request Result"
  echo "======"
  curl -s --fail --show-error  -o /dev/null $url$var && echo "SUCCESS: Code 200 for $var ====" || echo "FAILED"
  echo "======"
  echo ""
done

echo "---- URI TESTING END----"

echo ""

echo "---- BODY TESTING START----"
words="hello updated_time raga"
for var in ${words}
do
  echo ""
  echo "======"
  echo " Request to $url"
  curl -s  $url | grep -q $var && echo " SUCCESS: $var found in response" || echo " FAILED: $var not found in response"
  echo "======"
  echo ""
done
echo "---- BODY TESTING END----"
