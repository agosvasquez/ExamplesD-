module account;
import core.sync.mutex;
import std.stdio: write, writeln, writef, writefln;
import core.thread : Thread;
import lock;

class Account
{
    Mutex mtx;
    int balance;

    this() shared @safe nothrow
    {
        mtx = new shared Mutex();
        balance = 0;
    }

    void deposit(int amount) shared @safe nothrow
    {
        auto lock = new shared Lock(mtx);
        (cast() balance) += amount;
    }

    void withdraw(int amount) shared @safe nothrow
    {
        auto lock = new shared Lock(mtx);
        (cast() balance) -= amount;
    }

    int getBalance() shared @safe nothrow
    {
        auto lock = new shared Lock(mtx);
        return balance;
    }
}