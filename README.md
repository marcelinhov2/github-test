#Github-Test
AngularJS application using Angular-Kickoff ( https://github.com/marcelinhov2/angular-kickoff )

##App Link
https://secure-dusk-2559.herokuapp.com/

##Features
* Allows users to search for users/orgs and repositories at Github;

##Installation

Clone repo using git
```sh
git clone git@github.com:marcelinhov2/github-test.git
cd github-test
```

Install dependencies
```sh
make setup
```

###Running the App during Development
This command automatically compiles coffee, jade and stylus, injects bower components, starts livereload server and opens your app in the browser.
```sh
make server
```

###Compiling app for development
This command compiles project. Output goes to ```www/``` folder
```
make compile
```

###Building the App for Production
This command compiles project and optimizes it for production. Output goes to ```dist/``` folder
```
make build
```
