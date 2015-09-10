**CREATE DB:**
You can manually create db using your preferred dbms software, otherwise you can run create_mysql.sql file that you find in "create" folder. It will create world/chars/auth databases entities for you.

**INSTALL DB:**
To install data you can use db-tools.js nodejs script. Run it using

>> node db-tools.js 

and then choose "make full db" option to create
world.sql, chars.sql and auth.sql file in "databases" folder ready to be imported directly to your database.

**UPDATE:**
To update your db with latest changes, you can run db-tools.js choosing "make updates" option. It creates sql files in "updates" folder , ready to be imported in your database.


