<?php
/*
* Copyright 2012 Jerome Quere < contact@jeromequere.com >.
*
* This file is part of SpotifyDJ.
*
* SpotifyDJ is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* SpotifyDJ is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with SpotifyDJ.If not, see <http://www.gnu.org/licenses/>.
*/
?>
<div class="container-fluid">
  <div class="row-fluid">
    <div class="span12">
      <div data-bind="visible: currentTrack().uri != ''">
	<div class="listView-header">
	  Currently Playing
	</div>
	<ul class="listView">
	  <li>
	    <img class="thumbmail" data-bind="attr: {src: currentTrack().albumImg}" />
	    <h2 data-bind="text: currentTrack().trackName">...</h2>
	    <p data-bind="text: currentTrack().artistName">...</p>
	    <span class="badge" data-bind="text: currentTrack().nbVotes + ' votes'"></span>
	  </li>
	</ul>
      </div>
      <div class="listView-header">
	To Come ...
      </div>
      <ul class="listView" data-bind="foreach: queue">
	<li data-bind="click: $root.onTrackClick">
	  <img class="thumbmail" data-bind="attr:{src: albumImg}" />
	  <h2 data-bind="text: trackName">..</h2>
	  <p data-bind="text: trackName">...</p>
	  <span class="badge" data-bind="text: nbVotes + ' votes'"></span>
	  <img class="icon" data-bind="attr: {src: haveMyVote() ? 'images/star_full.png' : 'images/star_empty.png'}"/>
	</li>
      </ul>
    </div>
  </div>
</div>
