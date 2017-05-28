var team =["max", "jane"]; //returns names of team
var bios = ["this is a bio statement", "this is another"];
var imgNames = ["geometry.png"];

var modal = Document.getElementbyId("bio");
var title = Document.getElementbyId("modalTitle");
var aboutText = Document.getElementbyId("aboutText");
var bioImg = Document.getElementbyId("bioModalImg");

function populate(num)
{
  title.innerHTML = team[num];
  aboutText.innerHTML = bios[num];
  imgNames.innerHTML = imgNames[num];
  $("#bio").modal('show');

}