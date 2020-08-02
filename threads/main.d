module main;
import summation;
import account;

void main()
{
    import core.thread : Thread;
    import std.stdio: write, writeln, writef, writefln;

    shared Account account = new shared Account();
    Thread[20] threads;

    for (int i = 0; i < 20; i++) {

        auto thread = new Sum(
        1,
        10,
        &account).start();
        threads[i] = thread;
    }

    for (int i = 0; i < 20; i++) {
        threads[i].join();
    }

    int balance = account.getBalance();
    writeln(balance);


}
