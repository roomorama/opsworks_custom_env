This cookbook maintains a `.env` file in each respective app's deploy directory. E.g.:

    FOO: "http://www.yahoo.com"
    BAR: "1001"

Your application can then load its settings directly from this file using dotenv (https://github.com/bkeepers/dotenv).

Expects attributes of the form:

    {
      "custom_env": {
        "my_app": {
          "FOO": "http://www.yahoo.com",
          "BAR": "1001"
        },
        "your_app": {
          "BAZ": "99"
        }
      }
    }


Opsworks Set-Up
---------------

The `opsworks_custom_env::configure` recipe should be added as a custom recipe to the _Setup_, _Configure_, and _Deploy_ events.

A deploy is not necessary to update custom application environment values. Instead, update the Stack's custom JSON,
then choose to _Run Command_ > _execute recipes_ and enter `opsworks_custom_env::update` into the _Recipes to execute_ field.
Executing this recipe will write an updated `.env` file and restart web server process.
