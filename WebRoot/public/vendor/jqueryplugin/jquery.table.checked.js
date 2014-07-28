/*
 * jQuery table checked plugin
 * https://github.com/applesstt/jq-table-striped
 *
 * Author: liyachuan
 * Date: 2013-05-07
 */
;(function ( $, window, document, undefined ) {
    var pluginName = "tbChecked",
        defaults = {
            allCheck: '',
            check: '',
            rowClick: false
        };

    function Plugin ( element, options ) {
        this.element = element;
        this.$element = $(element);
        this.options = $.extend( {}, defaults, options );
        this._defaults = defaults;
        this._name = pluginName;
        this.init();
    }

    Plugin.prototype = {
        init: function () {
            var self = this;
            var allCheck = $.trim(this.options.allCheck);
            if(allCheck !== '') {
                $(allCheck).click(function() {
                    self._check_all($(this).prop('checked'));
                })
            }
        },
        getChecked: function() {
            var check = $.trim(this.options.check);
            var valAry = [];
            this.$element.find(check).filter(':checked').each(function() {
                valAry.push($(this).val());
            });
            return valAry;
        },
        checkAll: function(flag) {
            _check_all(flag);
        },
        _check_all: function(flag) {
            flag = flag && true;
            var check = $.trim(this.options.check);
            this.$element.find(check).prop('checked', flag);
        }
    };

    $.fn[ pluginName ] = function ( options ) {
        return this.each(function() {
            if ( !$.data( this, "plugin_" + pluginName ) ) {
                $.data( this, "plugin_" + pluginName, new Plugin( this, options ) );
            }
        });
    };

})( jQuery, window, document );