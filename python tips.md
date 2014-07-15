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