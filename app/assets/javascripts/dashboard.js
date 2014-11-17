(function(){
  "use strict";

  window.Missions = window.Missions || {};

  function Dashboard(options) {
    this.$dashboard = options.el;
    this.$placeholder = this.$dashboard.find('.placeholder');

    this.dataSource = options.dataSource;
    this.interval = 5000;

    this.loadMissions();
  }

  Dashboard.prototype.loadMissions = function loadMissions(){
    window.console.log('Loading missions');
    $.getJSON(this.dataSource, $.proxy(this.setMissions, this));
  }

  Dashboard.prototype.setMissions = function setMissions(missions){
    this.clearMissionsList();

    // schedule the display of each mission
    $.each(missions, $.proxy(this.scheduleMissionDisplay, this));

    // schedule the next load of the missions
    var restartDuration = this.interval * missions.length;
    window.console.log('Scheduling reload of the list in '+ missions.length + 'x' + this.interval + ' = ' + restartDuration + 'ms');

    setTimeout( $.proxy(this.loadMissions, this), restartDuration);
  }

  Dashboard.prototype.scheduleMissionDisplay = function scheduleMissionDisplay(index, mission) {
   setTimeout(
     $.proxy( function(){
       this.insertMission(mission)
     }, this),
     index * this.interval
   );
  }

  Dashboard.prototype.clearMissionsList = function clearMissionsList() {
    this.$dashboard.find('.mission:not(.placeholder)').fadeOut('slow', function(){
      $(this).remove();
    });
  }

  Dashboard.prototype.insertMission = function insertMission(attributes){
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
