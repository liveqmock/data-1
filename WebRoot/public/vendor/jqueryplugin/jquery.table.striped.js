/*
 * jQuery table striped plugin
 * https://github.com/applesstt/jq-table-striped
 *
 * Author: liyachuan
 * Date: 2013-05-07
 */
(function ($) {
    $.tbStrip = function (element, options) {
        var defaults = {
            odd: '',
            even: '',
            hover: '',
            hoverTextColor: '',
            startLine: 1
        };
        var plugin = this;
        plugin.settings = {}
        var $element = $(element),
            element = element;
        plugin.init = function () {
            plugin.settings = $.extend({}, defaults, options);
            var odd = $.trim(plugin.settings.odd);
            var even = $.trim(plugin.settings.even);
            var hover = $.trim(plugin.settings.hover);
            _triped_tr($element, odd, even);
            if(hover !== '') {
                $element.find('tbody tr').hover(function() {
                    _remove_class($(this), odd);
                    _remove_class($(this), even);
                    _add_class_or_color($(this), hover);
                }, function() {
                    _remove_class($(this), hover);
                    _triped_tr($element, odd, even);
                })
            }
        }
        /*
            plugin.foo_public_method = function () {}
         */
        var _add_class_or_color = function(jqEle, class_or_color) {
            var isClass = _check_is_class(class_or_color);
            if(isClass) {
                jqEle.addClass(class_or_color);
            } else {
                jqEle.css('backgroundColor', class_or_color);
            }
        };
        var _remove_class = function(jqEle, className) {
            var isClass = _check_is_class(className);
            if(isClass) {
                jqEle.removeClass(className);
            }
        };
        var _triped_tr = function(jqEle, odd, even) {
            if(odd !== '') {
                _add_class_or_color(jqEle.find('tbody tr:odd'), odd);
            }
            if(even !== '') {
                _add_class_or_color(jqEle.find('tbody tr:even'), even);
            }
        }
        /**
         * if str like #aa0000 return false else return true
         */
        var _check_is_class = function (str) {
            var colorReg = /^#[0-9a-fA-F]{6}$/;
            return str.match(colorReg) == null;
        }
        plugin.init();
    }
    $.fn.tbStrip = function (options) {
        return this.each(function () {
            if (undefined == $(this).data('tbStrip')) {
                var plugin = new $.tbStrip(this, options);
                $(this).data('tbStrip', plugin);
            }
        });
    }
})(jQuery);
