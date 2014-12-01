angular.module('filters',[])
    .filter('odd', function () {
    return function(input) {
        if (input.Id % 2 == 1) {
            return input;
        }
    };
    });





