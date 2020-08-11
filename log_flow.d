module log_flow;
import std.stdio;
import std.string;
import std.format;
import std.exception;
import std.conv;
import std.array;
import core.thread;

class SignOnFlow : Fiber {
		/* The data read most recently for this flow. */
		string inputData_;

		/* The information to construct a User object. */
		string name;
		string email;
		uint age;

		this() {
			/* Set our 'run' member function as the starting point
			* of the fiber. */
			super(&run);
		}

		void run() {
			/* First input is name. */
			name = inputData_;
			Fiber.yield();

			/* Second input is email. */
			email = inputData_;
			Fiber.yield();

			/* Last input is age. */
			age = inputData_.to!uint;

			/* At this point we have collected all information to
			* construct the user. We now "return" instead of
			* 'Fiber.yield()'. As a result, the state of this
			* fiber becomes Fiber.State.TERM. */
		}

		/* This property function is to receive data from the
		* caller. */
		void inputData(string data) {
			inputData_ = data;
		}

		/* This property function is to construct a user and
		* return it to the caller. */
		//PersonaFisica persona() const {
		//	return PersonaFisica(name, email, age);
		//}
	}
