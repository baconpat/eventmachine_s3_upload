This is a sample project that illustrates some strange behavior I ran into trying to upload files to Amazon S3 using [EventMachine][http://rubyeventmachine.com/] and the [happening][http://github.com/peritor/happening] non-blocking S3 client.

You need to update the s3.yml file with your S3 account information and run `bundle install`. Then you can run either of the two included scripts:

`ruby lib/http_upload.rb`

or

`ruby lib/https_upload.rb`

On my machine (Mac OS X) when I run the **https** script the CPU spikes to 100% and the event loop is blocked for a couple of minutes before the file starts to transfer. However, the **http** version does not block the event loop, uses almost no CPU, and starts transferring data right away.