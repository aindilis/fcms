// if (Boolean(sessionStorage.getItem("sidebar-menu-collapsed"))) {
//     $("body").removeClass('sidebar-collapse')
// }

// $('.sidebar-menu').click(function() {
//     event.preventDefault();
//     if (Boolean(sessionStorage.getItem("sidebar-menu-collapsed"))) {
// 	sessionStorage.setItem("sidebar-menu-collapsed", "");
//     } else {
// 	sessionStorage.setItem("sidebar-menu-collapsed", "1");
//     }
// });

// $(document).ready(function() {
//     // Document ready code here
// }

// $.AdminLTESidebarTweak = {};

// $.AdminLTESidebarTweak.options = {
//     EnableRemember: true,
//     NoTransitionAfterReload: false
//     //Removes the transition after page reload.
// };

// $(function () {
//     "use strict";

//     $("body").on("collapsed.pushMenu", function(){
// 	if($.AdminLTESidebarTweak.options.EnableRemember){
// 	    document.cookie = "toggleState=closed";
// 	}
//     });
//     $("body").on("expanded.pushMenu", function(){
// 	if($.AdminLTESidebarTweak.options.EnableRemember){
// 	    document.cookie = "toggleState=opened";
// 	}
//     });

//     if($.AdminLTESidebarTweak.options.EnableRemember){
// 	var re = new RegExp('toggleState' + "=([^;]+)");
// 	var value = re.exec(document.cookie);
// 	var toggleState = (value != null) ? unescape(value[1]) : null;
// 	if(toggleState == 'closed'){
// 	    if($.AdminLTESidebarTweak.options.NoTransitionAfterReload){
// 		$("body").addClass('sidebar-collapse hold-transition').delay(100).queue(function(){
// 		    $(this).removeClass('hold-transition');
// 		});
// 	    }else{
// 		$("body").addClass('sidebar-collapse');
// 	    }
// 	}
//     }
// });
