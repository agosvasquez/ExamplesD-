module lock;
import core.sync.mutex;

class Lock {
private:
	Mutex mtx;

public:
	// Constructor
	this(shared Mutex mutex) shared @safe nothrow {
		mtx = mutex;
		mtx.lock_nothrow();
	}

	// Destructor
	~this() shared @safe nothrow {
		mtx.unlock_nothrow();
	}
}
