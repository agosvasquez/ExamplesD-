module main;
import core.sync.mutex;
import std.stdio: write, writeln, writef, writefln;
import core.thread : Thread;
import sum;
import account;

void main()
{
    shared Account* account;
    Sum[20] threads;

    for (int i = 0; i < 20; i++) {

        threads[i] = new Sum(
        1,
        10, account
        );
    }

    for (int i = 0; i < 20; i++) {
        threads[i].start();
    }

    for (int i = 0; i < 20; i++) {
        threads[i].join();
    }

    int balance = account.getBalance();gi
    writeln(balance);


}
