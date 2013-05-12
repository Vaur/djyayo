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

nconf = require('nconf');
Application = require('./Application.coffee');
Logger = require('./Logger.coffee');

nconf.argv();
nconf.file(nconf.get('config'))
nconf.defaults({
'httpPort': 4242,
'spotifyPort': 4343
'FacebookAppKey': "YOUR_FACEBOOK_APP_KEY",
'FacebookSecretKey': "YOUR_FACEBOOK_SECRET"
});


main = (argc, argv) ->
	application = new Application();
	application.run();

main(process.argv.length, process.argv)