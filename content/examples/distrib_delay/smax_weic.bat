del nonmem*.exe
call \users\bauerr\nonmem\nmfe751 smax_weic.ctl smax_weic.res -tprdefault -dde -nmexec=nonmem%1.exe
call \users\bauerr\nonmem\nmfe751 smax_wei_rep.ctl smax_wei_rep.res -tprdefault -nmexec=nonmem%1b.exe
\users\bauerr\nm751\util\table_compare.exe smax_weic.tab smax_wei_rep.tab s s prec_6.xtl >smax_weic.txt
