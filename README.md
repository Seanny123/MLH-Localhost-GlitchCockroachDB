Startrek Quotes with CockroachDB
================================

Quotes are queried from CockroachDB and displayed every few seconds.  
![preview](https://i.imgur.com/TiGjKH8.png)

Project on Glitch
=================

Project can be found on Glitch at [https://checker-aries.glitch.me/](https://checker-aries.glitch.me)

Troubleshooting
===============

**Note:** if you open a Glitch console and `cockroach` is installed, the `cockroach` command will still not be found until you run `alias cockroach="~/.data/cockroach"`

### Troubleshooting `BRB! Connecting to CockroachDB`

This happens occassionally when the project has been running for a while. It may go to sleep. Simply reload the page and wait a few minutes while the project wakes up and restarts the DB process.

If the app is really unresponsive, you may also go into the Glitch Console and type `sh cockroach.sh` to run the cockroachDB process manually. Hit `enter` to execute the DB process. You should see a bunch of output on the Glitch console.

### App is still not responding and `EADDRINUSE :::3000` appears in the Glitch Log

You have no choice but to kill the server.js process in the Glitch Console.
![error]("https://i.imgur.com/nzQsauv.png")

* Go to the Glitch Console
* Type `ps -ax` to see a list of all running processes.
* Find the process `node server.js` and note the PID.
* Finally, kill that process by running `kill [PID]` 
![kill]("https://i.imgur.com/0u8U6qS.png")
  
Don't worry about restarting the node server.js as Glitch will do this automatically. You may return to your project on Glitch IDE and check the log to ensure you have no issues.

### Running out of space

This only occured once during testing, but sometimes CockroachDB can run out of space on Glitch. In this case, remove the files `cockroach-data`, `mlh-node1` and `mlh-node2`. Then restart and refill the databases.
