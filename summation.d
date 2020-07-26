module sum;
import core.sync.mutex;
import std.stdio: write, writeln, writef, writefln;
import core.thread : Thread;
import result;


class Sum: Thread {
    int* start;
    int* end;
    ResultProtected* result;

    this(int* start, int* end, ResultProtected* result) @safe nothrow
    {
        super(&run);
        start = start;
        end = end;
        result = result;
    }
    void run () {
        int temporal_sum = 0;
        for (int *p = start; p < end; ++p) {
            temporal_sum += *p;
        }
        result.inc(temporal_sum);
    }
}