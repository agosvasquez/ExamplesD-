module summation;
import core.sync.mutex;
import std.stdio: write, writeln, writef, writefln;
//import core.thread.osthread;
import core.thread : Thread;
import account;


class Sum: Thread {
    int start_int;
    int end_int;
    shared Account* account;

    this(int received_start, int received_end, shared Account* _account)@safe nothrow
    {
        this.start_int = received_start;
        this.end_int = received_end;
        account = _account;
        super(&run);
    }
private:
    void run () {
        for (int p = this.start_int; p < this.end_int; p++) {
            account.deposit(p);
        }
    }
}