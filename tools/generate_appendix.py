#!/usr/bin/env python

def generate_entry(crossings, index):
    print (r"\begin{minipage}[b]{.18\linewidth}")
    print (r"\centering")
    print ("\\includegraphics[width=\\linewith]{{../images/{0}_{1}.png}}".format(crossings, index))
    print ("\\subcaption{{${0}_{{{1}}}$}}".format(crossings, index))
    print (r"\end{minipage}")

COUNTER = 0
KNOTS = {
    3: 1,
    4: 1,
    5: 2,
    6: 3,
    7: 7,
    8: 21,
    9: 49,
    10: 165,
}

for i in KNOTS.keys():
    for j in range(1, 1+KNOTS[i]):
        if COUNTER % 5 == 0:
            print(r"\begin{figure}")
        generate_entry(i, j)
        COUNTER = COUNTER + 1
        if COUNTER % 5 == 0 and COUNTER > 0:
            print(r"\end{figure}")
            print("")

if COUNTER % 5 != 0:
    print(r"\end{figure}")
