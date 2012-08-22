# Six degrees challenge

## To run:

1. Navigate to the project directory: **`cd <some_path>/sixdegrees`**

2. Install the proper gems: **`bundle`**

3. Setup the database: **`rake db:create; rake db:migrate`**

4. Start the server: **`unicorn_rails -l 0.0.0.0:3000` or `rails server`**

5. Open browser and navigate to [http://localhost:3000](http://localhost:3000)

#### Use the file upload form at the bottom of the page to select an XML file or simply hit the 'Load XML' button to load the provided sample data

#### Once movies and actors are loaded, click the link to any actor's name to see a page listing all degrees of separation between that actor and all the others.