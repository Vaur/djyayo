##
# Copyright 2012 Jerome Quere < contact@jeromequere.com >.
#
# This file is part of SpotifyDJ.
#
# SpotifyDJ is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# SpotifyDJ is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with SpotifyDJ.If not, see <http://www.gnu.org/licenses/>.
##

class HttpResponse
	constructor: (@response) ->
		@code = 200
		@headers = {}
		@buffer = new Buffer("");

	setCode: (@code) =>
	setContentType: (contentType) =>
		@headers['Content-Type'] = contentType

	enableCache: () =>
		@headers['Cache-Control'] = 'must-revalidate';
		@headers['Expires'] = 'Fri, 03 Jan 2042 23:42:00 GMT'

	enableCrossDomain: () =>
		@headers['Access-Control-Allow-Origin'] = '*'
		@headers['Access-Control-Request-Headers'] = 'origin, content-type, accept'

	setCookie: (name, value) =>
		if (@headers['Set-Cookie']?)
			@headers['Set-Cookie'] = @headers['Set-Cookie'].concat "#{name}=#{value}";
		else
			@headers['Set-Cookie'] = "#{name}=#{value}; Path=/;";

	write : (str) =>
		@writeBuffer(new Buffer(str));

	writeBuffer: (buf) =>
		newBuffer = new Buffer(@buffer.length + buf.length);
		@buffer.copy(newBuffer);
		buf.copy(newBuffer, @buffer.length);
		@buffer = newBuffer;

	end: (str) =>
		if (str?)
			@write(str)
		@response.writeHead(@code, @headers)
		@response.end(@buffer)

	@response
	@code
	@headers
	@buffer


module.exports = HttpResponse;