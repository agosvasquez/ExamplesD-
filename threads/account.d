module account;
import core.sync.mutex;
import std.stdio: write, writeln, writef, writefln;
import core.thread : Thread;

class Account   
{
    shared Mutex mtx;
    int balance;

    this() shared @safe nothrow
    {
        mtx = new shared Mutex();
        balance = 0;
    }

    void deposit(int amount) shared @safe nothrow
    {
        mtx.lock_nothrow();
        (cast() balance) += amount;
        mtx.unlock_nothrow();
    }

    void withdraw(int amount) shared @safe nothrow
    {
        mtx.lock_nothrow();
        (cast() balance) -= amount;
        mtx.unlock_nothrow();
    }

    int getBalance() shared @safe nothrow
    {
        mtx.lock_nothrow();
        int b = balance;
        mtx.unlock_nothrow();
        return b;
    }
}