module result;
import core.sync.mutex;
import std.stdio: write, writeln, writef, writefln;
import core.thread : Thread;

class ResultProtected
{
    Mutex mtx;
    int result;

    this() shared @safe nothrow
    {
        mtx = new shared Mutex();
        result = 0;
    }

    void inc(int s) shared @safe nothrow @nogc
    {
        mtx.lock_nothrow();
        (cast() result) += s;
        mtx.unlock_nothrow();
    }
    int get_val() shared @safe nothrow @nogc
    {
        mtx.lock_nothrow();
        int val = result;
        //implementar lock propio para sacar este unlock y que vaya en destructor
        mtx.unlock_nothrow();
        return val;
    }
}