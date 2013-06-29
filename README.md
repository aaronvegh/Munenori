#Munenori: An ADN Direct Message Application for Mac OS X#

This app was developed by Aaron Vegh for the [Objective-C Hackathon](http://objectivechackathon.appspot.com). Go Objective-C! 

It's a fun project to see what's involved in interacting with the App Dot Net API. It's fantastic, as it happens. This implementation is the result of about 6 hours of work, so it's rough. Real rough.

If you want to run this app, you need to know this:

1. You'll need to provide your own ADN Developer Key and Secret. 
2. I'm using the OAuth authentication flow, which opens a web view and gets an access token. My understanding is that you have to log in like this every time you start the app. But I might be able to figure out how to store the token and use it across launches.
3. You can't create new messaging channels; once logged in, it only shows you the channels you're already a part of.
4. You can only view the messages for one channel per app launch, because I'm an idiot about how to code the chat window. Hey, I said 6 hours' work, right?
5. You can post messages, but yeah: you can't see the post appear in the chat. Six. Hours.
6. Ugly. Oh my god, the ugly.

###Credits###

My thanks to the following projects, whose code appears in this work:

* [Cocoapods](http://cocoapods.org)
* [AFNetworking](http://afnetworking.com)
* [ADNKit](https://github.com/joeldev/ADNKit)
* [JLRoutes](https://github.com/joeldev/JLRoutes)
* [NSWindowButtons](https://github.com/blladnar/NSWindowButtons)

###License###
BSD 3-Clause License:

> Copyright (c) 2013, Aaron Vegh. All rights reserved.
 
> Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
>Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of JLRoutes nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

> THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.