##
# Copyright 2012 Jerome Quere < contact@jeromequere.com >.
#
# This file is part of SpotifyDj.
#
# SpotifyDj is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# SpotifyDj is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with SpotifyDj.If not, see <http://www.gnu.org/licenses/>.
##

class RoomSelectController
	constructor: (@$scope, @$location, @webService) ->
		@$scope.roomName = "";
		@$scope.error = false;
		@$scope.selectRoom = @onSelectRoom

	onSelectRoom: () =>
		roomName = @$scope.roomName;
		promise = @webService.query "room/#{roomName}"
		promise.then (data) =>
			@$location.path("/room/#{data.name}");
		promise.then null, (data) =>
			@$scope.error = true