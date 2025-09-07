#! /bin/bash

echo "#!/bin/bash" > vpl_execution
echo "time python3 sqlgrader.py" >> vpl_execution

chmod +x vpl_execution
chmod +r database.sql