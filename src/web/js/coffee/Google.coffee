##
#The MIT License (MIT)
#
# Copyright (c) 2013 Jerome Quere <contact@jeromequere.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
##

class Google
	constructor: (@$rootScope, @$q, @config) ->
		@googleLoaded = @$q.defer();
		@loadGoogleSDK();

	login: () =>
		defer = @$q.defer();
		@googleLoaded.promise.then () =>
			params = {};
			params.client_id = @config.get("google.clientId");
			params.imediate = true;
			params.scope = 'https://www.googleapis.com/auth/plus.me'
			gapi.auth.authorize params, (authResponse) =>
				@scopeApply () =>
					defer.resolve(authResponse.access_token);

		return (defer.promise)


	scopeApply: (func) =>
		if (@$rootScope.$$phase && @$rootScope.$$phase == '$digest')
			func();
		else
			@$rootScope.$apply(func)

	loadGoogleSDK: () ->
		jQuery () =>
			window.googleAsyncInit = @onGoogleSDKLoaded
			po = document.createElement('script');
			po.type = 'text/javascript';
			po.async = true;
			po.src = 'https://apis.google.com/js/client:plusone.js?onload=googleAsyncInit';
			s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(po, s);

	onGoogleSDKLoaded: () =>
		@scopeApply () =>
			@googleLoaded.resolve(true);