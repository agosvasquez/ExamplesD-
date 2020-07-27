module result;
import core.sync.mutex;
import std.stdio: write, writeln, writef, writefln;
import core.thread : Thread;
import lock;

class ResultProtected
{
    Mutex mtx;
    int result;

    this() shared @safe nothrow
    {
        mtx = new shared Mutex();
        result = 0;
    }

    void inc(int s) shared @safe nothrow
    {
        auto lock = new shared Lock(mtx);
        (cast() result) += s;
    }

    int get_val() shared @safe nothrow
    {
        auto lock = new shared Lock(mtx);
        int val = result;
        return val;
    }
}