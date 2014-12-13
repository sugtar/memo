var showGrayLayer = function() {
    $('.grayLayer').show();
};

var hideGrayLayer = function() {
    $('.grayLayer').hide();
    hideInputArea();
};

var showInputArea = function() {
    $('.input_area').show();
};

var hideInputArea = function() {
    $('.input_area').hide();
};

var remote_test = function() {
    alert('remote test');
    console.log('test');
};

var bookmarklet_test = function() {
    alert('bookmarklet_test');
};

$(document).ready(function() {
    hideGrayLayer();
    $('.grayLayer').click(hideGrayLayer);
});
