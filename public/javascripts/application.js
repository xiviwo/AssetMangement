// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

assign: function(){
Hobo.ajaxRequest('/assignments/assign', ['assignment'], {refocusForm:true, resetForm:true}); 
return false;
};