module sum;
import core.sync.mutex;
import std.stdio: write, writeln, writef, writefln;
import core.thread : Thread;
import account;


class Sum: Thread {
    int start;
    int end;
    shared Account* account;

    this(int start, int end, shared Account* account) @safe nothrow
    {
        super(&run);
        start = start;
        end = end;
        account = account;
    }
    void run () {
        for (int p = start; p < end; ++p) {
            account.deposit(p);
        }
    }
}