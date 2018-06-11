### This file handles the cockroachdb provisioning and configuration.
### We'll rerun it continuously, so try to keep its items idempotent and speedy-enough.

# work out of the .data folder so that remixes start fresh.
cd ~/.data

### This first batch of lines implements the basic cockraochdb install
### https://www.cockroachlabs.com/docs/build-a-nodejs-app-with-cockroachdb.html

# Download and extract the latest binary
if [ ! -f ./cockroach ]; then
    wget -N https://binaries.cockroachdb.com/cockroach-latest.linux-amd64.tgz
    tar xfz cockroach-latest.linux-amd64.tgz
    mv ./cockroach-latest.linux-amd64/cockroach .
    rm cockroach-latest.linux-amd64.tgz
    rm -rf ./cockroach-latest.linux-amd64
fi
    
# Instead of following instrutions and copying cockroach to /usr/bin,
# Let's set up an alias. This avoids needing to escalation permissions.
alias cockroach="./cockroach"


# basic check for if the above lines worked out OK
cockroach version 

# remove the preexisting environment so that we run fresh.
# (this deletes all the DB data, so we can repeat our assorted creation scripts.)
cockroach quit --insecure
rm -rf hello*

### Now, onward to start up the cluster!
### https://www.cockroachlabs.com/docs/build-a-nodejs-app-with-cockroachdb.html


# Start node 1:
cockroach start --insecure \
--store=hello-1 \
--host=localhost \
--background

# Start node 2:
cockroach start --insecure \
--store=hello-2 \
--host=localhost \
--port=26258 \
--http-port=8081 \
--join=localhost:26257 \
--background

# # Start node 3:
# cockroach start --insecure \
# --store=hello-3 \
# --host=localhost \
# --port=26259 \
# --http-port=8082 \
# --join=localhost:26257 \
# --background


# Create a user
cockroach user set maxroach --insecure

# Create DB and priviledges
cockroach gen example-data startrek | cockroach sql --insecure

# Check on the nodes
cockroach node ls --insecure

# Execute the example scripts:
node ~/proxy.js
node ~/server.js
#node ~/db.js
#node ~/js/quote.js



# Glitch will run this script in a loop, 
# so sleep for a bit to stablize the refresh rate of the site.
# This could be upgraded by monitoring the cockroach processes instead.
sleep 1m