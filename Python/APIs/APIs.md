---
tags:
  - Python
  - SoftwareEngineering
---
## 1. What are APIs?

API (Application Programming Interface), is a mechanism for two software components to communicate with each other using a defined set of protocols and requests.

For example, there might be an API that serves [[JSON]] data for the current weather. A weather app can request/consume this JSON data from the API using a HTTP request.

## 2. What is a RESTful API? REST 

REST stands for Representational State Transfer. 

REST defines a set of functions (verbs) such as GET, PUT and DELETE. The API consumer can use these commands access server data. 

### API guidelines

- Send/Return data in a JSON format
- Use nouns instead of verbs in endpoint paths

## 3. What is HTTP and HTTPS?

### HTTP

HTTP stands for Hypertext Transfer Protocol

HTTP operates on port 80 by default

HTTP messages are human-readable, making debugging easier

HTTP is the foundation of data communication on the World Wide Web. It is a stateless protocol, meaning each request from a client to a server is independent and unrelated to any previous requests


### HTTPS

HTTPS is an extension of HTTP that adds a layer of security using SSL/TLS encryption

The S stands for Secure

## 4. HTTP Request Structure

![HTTP Req Package](https://miro.medium.com/v2/resize:fit:720/format:webp/1*i2tUjWy44-dYT9qsaWbvig.png)

This is what a HTTP request looks like.

The URL is the API end point.

The method is the REST function being used (see no. 6)

The headers define meta data, such as cookies.
[List of Request Headers](https://flaviocopes.com/http-request-headers/)

Body is the data being sent.

## 5. HTTP Response Structure

![HTTP Resp Structure](https://miro.medium.com/v2/resize:fit:720/format:webp/1*w4gDd2TFunoOnrWy3xpHkQ.png)

This is a HTTP Response.

The status code tells you what sort of response it is.

200 = okay
404 = not found
500 = Internal Server Error

[List of HTTP Status Codes](https://www.webfx.com/web-development/glossary/http-status-codes/)

The data is the returned data. JSON in the case of APIs, HTML in the case of a normal webpage.

## 6. The 5 (main) HTTP Verbs

### End Point

The end point is the URL you are making the request to.

[List of request verbs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods)
### Get

Get data from the API, the returned data will probably be JSON

A get request doesn't normally have a body.
### Post

Send **new** data to the API, for example a new entry.

The body will be the data you want the API to process.

### Put

Put is used to send **updated** data to the API. This is for when you want to update the entire resource (eg, a full record in the database)

Note: Post is for new data, put is for update to existing data

### Patch

Patch is used for partial updates.

Such as, updating a users email only.
### Delete

Delete removes data from the resource.

## 7. What is statelessness?

The main feature of a REST API is statelessness. 

Statelessness means that servers do not save client data between requests. 

Client requests to the server are similar to URLs you type in your browser to visit a website. The response from the server is plain data, without the typical graphical rendering of a web page.

## 8. What is Caching?

To speed up responses caching is often used, it is also used to add resilicancy, or reduce hosting costs.

Generally caching can only be used on Get requests

A cache hit is where there is data in the cache, a miss is where there is not, and the data must be requested from elsewhere.
### A Caching Example

There is an API that serves weather data. There is an endpoint that allows the API consumer to request the current data for a particular weather station.

Without caching the API controller (that is hosted in 'the cloud') makes a special request to the weather station for the current readings.

The weather station is running on a mobile phone network, so bandwidth is low and the data cost is expensive. (so we don't want to be making lots of requests to it)

If you only have a few dozen requests per hour, your weather station can deal with this.

However, your API needs to serve 1M/requests per day, so this wouldn't work.

So you need to build a caching solution.

Weather station data is timely, but not *that* timely.

So lets store the returned data from the weather station for 5 minutes. This should be up to date enough for our API consumers. 

When a request is made the caching layer first looks in its data store (probably a fast in memory database, like Redis) to see what the newest data from the weather station is. In this case the data stored is only 35 seconds old. This is good data (a cache hit), so we'll return this directly to the API consumer.

This avoids us having to ask the weather station for the data, saving bandwidth and data costs.

Another request is made, this time the data is 5m4s old (a cache miss). This is older than our 5 min 'cache time'. In this case, the API controller will make a new request to the weather station for the most up to date data. It will then do two things, return this to the consumer, and store it in the cache database, along with a new timestamp.

As this caching is done in the cloud, you get much cheaper compute/bandwidth than you would on the weather station. It also allows you to resilient to outages in the mobile network or weather station.

### Other uses for caching

The same theory can be applied to other architectures. For example caching a pre calculated feed news feed (calculate once per hour, then you save this calculation for future requests, so you don't need to calculate it for all requests and users). Or adding a caching database like Redis in front of a relational database like MySQL. This caching layer stores some % of common requests or data from the RD for quick serving (and cheap!), while only passing a smaller number of requests to the slower, more expensive RD.

