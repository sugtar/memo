var mode="view";$(document).ready(function(){$("#memo_item_actions").removeClass("visible").addClass("hidden"),changeToEditMode=function(){mode="edit",$(".memo_item_actions").removeClass("hidden").addClass("visible"),$("#view_mode_link").removeClass("selected").addClass("unselected"),$("#edit_mode_link").removeClass("unselected").addClass("selected")},changeToViewMode=function(){mode="view",$(".memo_item_actions").removeClass("visible").addClass("hidden"),$("#view_mode_link").removeClass("unselected").addClass("selected"),$("#edit_mode_link").removeClass("selected").addClass("unselected")}});