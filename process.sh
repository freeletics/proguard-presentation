#!/bin/sh

for i in *.dot; do
  dot $i -Tpdf -o `basename $i .dot`.pdf
done