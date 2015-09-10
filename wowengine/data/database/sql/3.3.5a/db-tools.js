var child_process = require('child_process');
var readline = require('readline');
var fs = require("fs");
var path = require("path");

var config = require('./mysql-config.json');

var databases = ["chars", "auth", "world"];

function mainMenu () {
    var rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    var question = "Select action:\n" +
            "1) dump database\n" +
            "2) make full db\n" +
            "3) make updates\n";

    rl.question(question, function (answer) {
        console.log("Selected: " + answer);
        switch (answer) {
            case "1":
                prepareDump();
                break;
            case "2":
                makeFullDb();
                break;
            case "3":
                makeUpdates();
                break;
        }

        rl.close();
    });
}

function makeFullDb () {
    function make (name) {
        fs.readdir(__dirname + "/databases/" + name, function (err, files) {
            if (!err) {
                var outFile = __dirname + "/databases/" + name + ".sql";
                if (fs.existsSync(outFile))
                    fs.unlinkSync(outFile);

                files.forEach(function (e) {
                    console.log("processing: " + name + "/" + e);
                    fs.appendFileSync(outFile, fs.readFileSync(__dirname + "/databases/" + name + "/" + e));
                });
            }
        });
    }


    for (var id in databases) {
        make(databases[id]);
    }
}

function makeUpdates () {
    function make (name) {
        fs.readdir(__dirname + "/updates/" + name, function (err, files) {
            if (!err) {
                files = files.filter(function (e) {
                    return path.extname(e) === ".sql";
                });

                if (files.length === 0)
                    return;

                files = files.sort(function (a, b) {
                    return a < b ? -1 : 1;
                });

                var outFile = __dirname + "/updates/" + name + ".sql";

                var minorRev = parseInt(path.basename(files[0], ".sql").split("_")[1]);
                var maxRev = parseInt(path.basename(files[files.length - 1], ".sql").split("_")[1]);
                var curr = minorRev;

                var contents = "DELIMITER //\n"
                        + " DROP PROCEDURE IF EXISTS `updateDb`//\n"
                        + " CREATE PROCEDURE updateDb ()\n"
                        + " proc:BEGIN\n"
                        + "     DECLARE dbVersion INT DEFAULT -1;\n"
                        + "     SELECT " + name + "_db_version INTO dbVersion FROM `version` LIMIT 1;\n"
                        + "     IF dbVersion < " + (minorRev-1) + " THEN\n"
                        + "         SELECT CONCAT('** ', 'We cannot update your database, maybe your db is outdated, try an oldest version of this file') AS '** ERROR:';\n"
                        + "         LEAVE proc;\n"
                        + "     END IF;\n";

                fs.writeFileSync(outFile, contents);

                files.forEach(function (e) {
                    contents = "       IF dbVersion < " + curr + " THEN\n"
                            + fs.readFileSync(__dirname + "/updates/" + name + "/" + e)
                            + "      END IF;\n";

                    console.log("processing: " + name + "/" + e);
                    fs.appendFileSync(outFile, contents);
                    curr++;
                });

                contents = ""
                        + "       IF dbVersion = " + maxRev + " THEN\n"
                        + "            SELECT CONCAT('** ', 'Your db is already updated') AS '** INFO:';\n"
                        + "            LEAVE proc;\n"
                        + "       END IF;\n"
                        + "       IF dbVersion > " + maxRev + " THEN\n"
                        + "            SELECT CONCAT('** ', 'Your revision is not supported, maybe you need an newer version of this file') AS '** ERROR:';\n"
                        + "            LEAVE proc;\n"
                        + "       END IF;\n"
                        + "   END;\n"
                        + "  //\n"
                        + "DELIMITER ;\n"
                        + "CALL updateDb ();\n"
                        + "DROP PROCEDURE IF EXISTS `updateDb`\n";

                fs.appendFileSync(outFile, contents);
            }
        });
    }


    for (var id in databases) {
        make(databases[id]);
    }
}

function prepareDump () {
    for (var dbName in config.db) {
        runDump(dbName, config.db[dbName]);
    }
}


function runDump (database, jsonConf, callback) {
    var conf = "MYSQL_USER='" + jsonConf.user + "'"
            + ";MYSQL_PASS='" + jsonConf.pass + "'"
            + ";MYSQL_HOST='" + jsonConf.host + "'"
            + ";TPATH='" + jsonConf.outPath + "'"
            + ";CLEANFOLDER=1"
            + ";CHMODE=0"
            + ";TEXTDUMPS=0"
            //+ "; FPATH='" + jsonConf.dumpfile 
            + ";PARSEDUMP=1;";

    conf += "DUMPOPTS='--skip-comments --skip-set-charset --routines --extended-insert --order-by-primary --single-transaction --quick';";

    child_process.execFile(
            "../../../../../udw/mysql-tools/mysql-tools",
            ["dump", "", database, "0", conf],
            {cwd: __dirname},
    function (error, stdout, stderr) {
        console.log(stdout);
        error && console.log(error, stderr);

        callback && callback();
    }
    );
}

function main () {
    mainMenu();
}

main();

