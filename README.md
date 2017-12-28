# Image Resizer Challenge - Made in Ruby
This repository contains code, in ruby, that solve the Image Resizer Challenge. This is a cool case to study because it envolves:
- Image manipulation;
- Rest API (a really simple example of consumption and creation);
- TDD - How to mock external sources and test it;
- Cache with MongoDB;
- This is a real example that can be used to provide images at exact size that some websites needs;

Also I used a lot of technologies in that project:
- [Sinatrarb](sinatrarb.com) - A very lightweight ruby framework, ideal to create smalls APIs;
- [MongoDB](mongodb.com) - A NoSQL database that is very good to cache information;
- [Down](https://github.com/janko-m/down) - A Ruby gem that makes download files easier;
- [Image_proc](https://github.com/julik/image_proc) - A Ruby gem that allows resize images without the needs to install external dependencies (such as libgd).

## What is the Image Resizer Challenge
I had to download some images from external API and provide these images at various sizes at other API.
So this software was divided at some parts, and all of they are glued together at server.rb.

## Steps to download and run
First of all, this project was only tested at Ubuntu. It is not guaranteed that it will work at Mac or Windows.
To run that, with cache capability, you will need the MongoDB. I recommend that you use the [Mongo Docker Image](https://hub.docker.com/_/mongo/). If you prefer, you can refeer to [Mongo official installation docs](https://docs.mongodb.com/manual/installation/) in order to install it.

1. Download or clone this repository
2. Navigate to this repository
> $ cd ~/where-you-downloaded-repo
3. Download all dependencies
> $ bundle
4. Run all tests to ensure that you haven't downloaded a broke version:
> $ rake
5. Run sinatra
> $ ruby server.rb

If you want, you can run it without MongoDB installed, but you will loose the cache capability. To do that, open server.rb and comment the cache configuration section.

Other configurations like api endpoint are also into server.rb.

## Available endpoints
After run server.rb, you can access two endpoints (both by get method). Assuming that you're running sinatra at default port on localhost:

1. List all images urls -> http://localhost:4567/image
2. Get some image -> http://localhost:4567/image/{{image_name_here}}

All images are available at four different resolutions:
- Original
- Small (320x240)
- Medium (384x288)
- Large (640x480)

If you want to download some image at any of resolutions describe above, you just need to attach resolution to file name using "_" (underscore) as separator character.

Example:

``` ruby
http://localhost:4567/image #Returns a json with all available images url
http://localhost:4567/image/foo.jpg #It will download original image
http://localhost:4567/image/foo_384_288.jpg #It will download foo at medium size
```

## And... Why Ruby?
I really like Ruby, less than Python, but I like it! But the [Skyhub Hells Triangle Challenge](https://github.com/ricardovsilva/skyhub-hells-triangle) I already solved using Python, and I want to show that I can write good Ruby code too!

Also Ruby has a sort of good technologies that fits very well at this challenge (like Sinatra). Ruby is a very flexible language, ease to write and easier to understand, with a really good and active community. If you're starting to develop and don't know what language to start, I really really recommend Ruby.

Thank you for reading this far. Any questions or sugestions, feel free to open an issue.