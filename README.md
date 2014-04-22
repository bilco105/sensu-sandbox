[Sensu](http://sensuapp.com) is often described as the “monitoring router”. Essentially, Sensu takes the results of “check” scripts run across many systems, and if certain conditions are met; passes their information to one or more “handlers”. Checks are used, for example, to determine if a service like Apache is up or down. Checks can also be used to collect data, such as MySQL query statistics or Rails application metrics. Handlers take actions, using result information, such as sending an email, messaging a chat room, or adding a data point to a graph. There are several types of handlers, but the most common and most powerful is “pipe”, a script that receives data via standard input. Check and handler scripts can be written in any language, and the community repository continues to grow!

This repo contains a Sensu demo environment to get you up and running quickly.

## Usage
The sandbox requires Vagrant and Bundler to be installed. 

    gem install bundler
    bundle install
    
Once bundler is installed, we'll use librarian-puppet to 'bundle' our required puppet modules:

    bundle exec librarian-puppet install
  
Finally, bring up the two node sensu cluster:

    vagrant up
    
The first time you bring up the sandbox instance, it will take some time to complete. 

Once the provisioning process is complete, you can access the Sensu Dashboard using http://172.20.20.3:8080 (user: admin, pass: secret)
