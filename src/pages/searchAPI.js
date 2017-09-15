(function (root) {

    var container = document.getElementById('container');
    var warning = document.getElementById('warning');

    var instance;
    var current = -1;

    root.init = function() {
        current = -1;
        instance && instance.revert();
    }

    root.find = function(value) {
        current = -1;
        instance && instance.revert();

        warning.style.display = 'none';
        if (value) {
            var called = false;
            try {
                instance = findAndReplaceDOMText(container, {
                    find: value,
                    replace: function(portion, match) {
                        called = true;
                        var el = document.createElement('em');
                        el.style.backgroundColor = 'lightgray';
                        el.innerHTML = portion.text;
                        return el;
                    },
                    forceContext: findAndReplaceDOMText.NON_INLINE_PROSE
                });
            } catch(e) {
                warning.innerHTML = 'Error: ' + e;
                warning.style.display = 'inline';
                throw e;
                return;
            }
            if (!called) {
                warning.innerHTML = 'No matches :(';
                warning.style.display = 'inline';
            }
        }

        // call next to move to the first result
        next();

        return instance.elements.length;
    };

    root.current = function() {
        return current;
    }

    root.next = function() {
        if (instance && instance.elements.length > 0) {

          // reset previous element style
          if (current >= 0) {
              instance.elements[current][0].style.backgroundColor = 'lightgray';
          }

          // move to the next element
          current += 1;

          // when the new index is out of bounds restart from 0
          if (current >= instance.elements.length) {
              current = 0;
          }

          var el = instance.elements[current][0];
          el.style.backgroundColor = 'gray';

          // scroll the view to the element
          window.scrollTo(0, offset(el).top);
        } else {
          current = -1;
        }

        return current;
    }

    root.prev = function() {
        if (instance && instance.elements.length > 0) {

          // reset previous element style
          if (current >= 0) {
              instance.elements[current][0].style.backgroundColor = 'lightgray';
          }

          // move to the next element
          current -= 1;

          // when the new index reaches 0 restart from the end
          if (current < 0) {
              current = instance.elements.length - 1;
          }

          var el = instance.elements[current][0];
          el.style.backgroundColor = 'gray';

          // scroll the view to the element
          window.scrollTo(0, offset(el).top);
        } else {
          current = -1;
        }

        return current;
    }

    function offset(el) {
        var rect = el.getBoundingClientRect();
        var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        return { top: rect.top + scrollTop }
    }

}(this));
