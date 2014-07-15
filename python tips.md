- Get current user path

``os.environ('USERPATH')``



- Thread sleep

``time.sleep(5)``



- Create http server in current folder from cmd. Default port: 8000. Python 3.

``python -m http.server ``



- Show all methods

``dir(function)``


- Performance timing

``from time import perf_counter``


- Namedtuple -- or create structs fast!


    from collections import namedtuple

    Jumps = namedtuple("Jumps", ["poz", "len"])

    aa = Jumps(len=66, poz=12)
    # aa = Jumps(6, 12)

    print(aa.poz, aa.len, aa)


- Itemgetter -- or access struct members fast!


    from operator import itemgetter

    a = [(5, 13721), (4, 13356), (6, 12216), (7, 10464), (3, 10407), (8, 7865), (9, 5780), (2, 4927), (10, 4018)]

    print(sorted(a, key=itemgetter(0), reverse=True))


- Counter -- count stuff.


    from collections import Counter

    arr = [(5, 13721), (4, 13356), (6, 12216), (4, 10464), (3, 10407), (4, 7865), (9, 5780), (5, 4927)]

    c = Counter([i for (i, j) in arr])
    print(c)
