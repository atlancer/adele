var FancyBox = function () {

    return {

        //Fancybox
        initFancybox: function () {
            jQuery(".fancybox").fancybox({
            padding: 5,
            groupAttr: 'data-rel',
            prevEffect: 'fade',
            nextEffect: 'fade',
            openEffect  : 'elastic',
            closeEffect  : 'fade',
            closeBtn: true,
            helpers: {
                title: {
                        type: 'float'
                    }
                }
            });

            $(".fbox-modal").fancybox({
                maxWidth    : 800,
                maxHeight   : 600,
                fitToView   : true,
                width       : '70%',
                height      : '70%',
                autoSize    : false,
                closeClick  : false,
                closeEffect : 'fade',
                openEffect  : 'elastic'
            });
        }

    };

}();