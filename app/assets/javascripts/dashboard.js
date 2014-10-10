(function(){
  "use strict";

  window.Missions = window.Missions || {};

  function Dashboard(options) {
    this.$dashboard = options.el;
    this.$placeholder = this.$dashboard.find('.placeholder');

    this.dataSource = options.dataSource;

    setInterval( $.proxy(this.loadMission, this), 5000 );
    this.loadMission();
  }

  Dashboard.prototype.loadMission = function loadMission(){
    window.console.log('Loading mission');
    $.getJSON(this.dataSource, $.proxy(this.setMission, this));
  }

  Dashboard.prototype.setMission = function setMission(attributes){
    var $existingMissions = this.$dashboard.find('.mission:not(.placeholder)');

    var $mission = this.$placeholder.clone();
    var $wrapper = $mission.find('.wrapper');

    $mission.removeClass('placeholder');

    $mission.find('img').attr('src', attributes.mission_patch_url);
    $mission.find('h1').text(attributes.name);

    if (attributes.team.name !== null) {
      $mission.find('h2').text(attributes.team.name);
    }

    $wrapper.hide();
    $mission.hide();

    $mission.prependTo(this.$dashboard).slideDown('fast', function(){
      $wrapper.fadeIn('fast');
    });
    $existingMissions.slice(4).fadeOut( 'slow', function() { $(this).remove(); });
  }

  Missions.Dashboard = Dashboard;
}());
