#!/bin/sh

testdir=`echo $0 | sed 's!/[^/]*$!!' || echo '.'`

# allow us to run tests standalone more easily
: ${srcdir="$testdir"}

# force VERBOSE if we're run on a subset of tests
test -n "$*" && VERBOSE=1

test -x "$testdir"/../src/cavern || testdir=.

: ${CAVERN="$testdir"/../src/cavern}
: ${DIFFPOS="$testdir"/../src/diffpos}

: ${TESTS=${*-"singlefix singlereffix oneleg midpoint noose cross firststn\
 deltastar deltastar2 bug3 calibrate_tape nosurvey2 cartesian cartesian2\
 lengthunits angleunits cmd_truncate cmd_case cmd_fix cmd_solve\
 cmd_entrance cmd_sd cmd_sd_bad cmd_fix_bad cmd_set cmd_set_bad\
 beginroot revcomplist break_replace_pfx bug0 bug1 bug2 bug4 bug5\
 expobug require export export2 includecomment\
 self_loop self_eq_loop reenterwarn cmd_default cmd_prefix\
 singlefixerr singlereffixerr\
 begin_no_end end_no_begin end_no_begin_nest require_fail\
 exporterr1 exporterr2 exporterr3 exporterr4 exporterr5\
 exporterr1b exporterr2b exporterr3b exporterr6 exporterr6b\
 hanging_cpt badinc badinc2 non_existant_file ONELEG\
 stnsurvey1 stnsurvey2 stnsurvey3\
 tapelessthandepth longname chinabug chinabug2\
 multinormal multinormignall multidiving multicylpolar multicartesian\
 multinosurv multinormalbad multibug\
 cmd_title cmd_titlebad cmd_dummy cmd_infer\
 cartes diving cylpolar normal normignall nosurv cmd_flags bad_cmd_flags\
 plumb unusedstation exportnakedbegin oldestyle bugdz baddatacylpolar\
 newline badquantities imgoffbyone infereqtopofil 3sdfixbug omitclino back\
 notentranceorexport inferunknown inferexports bad_units_factor\
 percent_gradient dotinsurvey leandroclino lowsd revdir"}}

for file in $TESTS ; do
  # how many warnings to expect
  warn=
  # how many errors to expect
  error=
  case "$file" in
  singlefix) pos=yes ; warn=1;;
  singlereffix) pos=yes ; warn=0 ;;
  oneleg) pos=yes ; warn=0 ;;
  midpoint) pos=yes ; warn=0 ;;
  noose) pos=yes ; warn=0 ;;
  cross) pos=yes ; warn=0 ;;
  firststn) pos=yes ; warn=0 ;;
  deltastar) pos=yes ; warn=0 ;;
  deltastar2) pos=yes ; warn=0 ;;
  bug3) pos=yes ; warn=0 ;;
  calibrate_tape) pos=yes ; warn=0 ;;
  nosurvey2) pos=yes ; warn=0 ;;
  cartesian) pos=yes ; warn=0 ;;
  cartesian2) pos=yes ; warn=0 ;;
  lengthunits) pos=yes ; warn=0 ;;
  angleunits) pos=yes ; warn=0 ;;
  cmd_truncate) pos=yes ; warn=0 ;;
  cmd_case) pos=yes ; warn=0 ;;
  cmd_fix) pos=yes ; warn=1 ;;
  cmd_fix_bad) pos=fail ; error=10 ;;
  cmd_solve) pos=yes ; warn=0 ;;
  cmd_entrance) pos=no ; warn=0 ;;
  cmd_sd) pos=no ; warn=0 ;;
  cmd_sd_bad) pos=fail ; error=7 ;;
  cmd_set) pos=no ; warn=0 ;;
  cmd_set_bad) pos=fail ; error=7 ;;
  beginroot) pos=no ;;
  revcomplist) pos=no ; warn=0 ;;
  break_replace_pfx) pos=no ; warn=0 ;;
  bug0) pos=no ; warn=0 ;;
  bug1) pos=no ; warn=0 ;;
  bug2) pos=no ; warn=0 ;;
  bug4) pos=no ; warn=0 ;;
  bug5) pos=no ; warn=0 ;;
  expobug) pos=no ; warn=0 ;;
  require) pos=no ; warn=0 ;;
  export) pos=no ; warn=0 ;;
  export2) pos=no ; warn=0 ;;
  includecomment) pos=no ; warn=0 ;;
  self_loop) pos=fail ; warn=0 ;;
  self_eq_loop) pos=no ; warn=1 ;;
  reenterwarn) pos=no ; warn=2 ;;
  cmd_default) pos=no ; warn=3 ;;
  singlereffixerr) pos=no ; warn=0 ;;
  cmd_prefix) pos=no ; warn=1 ;;
  singlefixerr) pos=no ; warn=1 ;;
  tapelessthandepth) pos=no ; warn=1 ;;
  chinabug2) pos=no ; warn=0 ;;
  longname) pos=no ; warn=0 ;;
  chinabug) pos=fail ;;
  begin_no_end) pos=fail ;;
  end_no_begin) pos=fail ;;
  end_no_begin_nest) pos=fail ;;
  require_fail) pos=fail ;;
  exporterr1) pos=fail ;;
  exporterr2) pos=fail ;;
  exporterr3) pos=fail ;;
  exporterr4) pos=fail ;;
  exporterr5) pos=fail ;;
  exporterr1b) pos=fail ;;
  exporterr2b) pos=fail ;;
  exporterr3b) pos=fail ;;
  exporterr6) pos=fail ;;
  exporterr6b) pos=fail ;;
  hanging_cpt) pos=fail ;;
  badinc) pos=fail ;;
  badinc2) pos=fail ;;
  non_existant_file) pos=fail ;;
  ONELEG) pos=fail ;;
  stnsurvey1) pos=fail ;;
  stnsurvey2) pos=fail ;;
  stnsurvey3) pos=fail ;;
  multinormal) pos=yes ; warn=0 ;;
  multinormignall) pos=yes ; warn=0 ;;
  multidiving) pos=yes ; warn=0 ;;
  multicylpolar) pos=yes ; warn=0 ;;
  multicartesian) pos=yes ; warn=0 ;;
  multinosurv) pos=yes ; warn=0 ;;
  multinormalbad) pos=fail ;;
  multibug) pos=no ; warn=0 ;;
  cmd_title) pos=no ; warn=0 ;;
  cmd_titlebad) pos=fail ; error=4 ;;
  cmd_dummy) pos=no ; warn=0 ;;
  cmd_infer) pos=yes ; warn=0 ;;
  cartes) pos=yes ; warn=0 ;;
  diving) pos=yes ; warn=0 ;;
  cylpolar) pos=yes ; warn=0 ;;
  normal) pos=yes ; warn=0 ;;
  normignall) pos=yes ; warn=0 ;;
  nosurv) pos=yes ; warn=0 ;;
  cmd_flags) pos=no ; warn=0 ;;
  bad_cmd_flags) pos=fail ; error=19 ;;
  plumb) pos=yes ; warn=0 ;;
  unusedstation) pos=no ; warn=2 ;;
  oldestyle) pos=no ; warn=1 ;;
  exportnakedbegin) pos=fail ;;
  bugdz) pos=yes ; warn=0 ;;
  baddatacylpolar) pos=fail ; error=1 ;;
  badnewline) pos=fail ; error=2 ;;
  badquantities) pos=fail ; error=11 ;;
  imgoffbyone) pos=yes ;; # don't actually care about coords, just the names
  infereqtopofil) pos=yes ; warn=0 ;;
  3sdfixbug) pos=yes ; warn=0 ;;
  omitclino) pos=yes ; warn=0 ;;
  back) pos=yes; warn=0 ;;
  notentranceorexport) pos=fail; warn=0 ;;
  inferunknown) pos=fail; error=1 ;;
  inferexports) pos=no; warn=0 ;;
  bad_units_factor) pos=fail; error=5 ;;
  percent_gradient) pos=yes; warn=0 ;;
  dotinsurvey) pos=no; warn=0 ;;
  leandroclino) pos=yes; warn=0 ;;
  lowsd) pos=no; warn=0 ;;
  revdir) pos=yes; warn=0 ;;
  *) file='' ;;
  esac

  if test -n "$file" ; then
    echo "$file"
    rm -f tmp.*
    if test -n "$VERBOSE" ; then
      if test fail = "$pos" ; then
        $CAVERN $srcdir/$file.svx --output=tmp
	# success gives 0, signal (128 + <signal number>)
	test $? = 1 || exit 1
      else
        $CAVERN $srcdir/$file.svx --output=tmp || exit 1
      fi
    else
      if test fail = "$pos" ; then
        $CAVERN $srcdir/$file.svx --output=tmp > tmp.out
	# success gives 0, signal (128 + <signal number>)
	test $? = 1 || exit 1
      else
        $CAVERN $srcdir/$file.svx --output=tmp > tmp.out || exit 1
      fi
    fi
    if test -n "$warn" ; then
      test -f tmp.out || $CAVERN $srcdir/$file.svx --output=tmp > tmp.out
      w=`sed '$!d;$s/^Done.*/0/;s/[^0-9]*\([0-9]*\).*/\1/' tmp.out`
      test x"$w" = x"$warn" || exit 1
    fi
    if test -n "$error" ; then
      test -f tmp.out || $CAVERN $srcdir/$file.svx --output=tmp > tmp.out
      e=`sed '$!d;$s/^Done.*/0/;s/[^0-9]*[0-9][0-9]*[^0-9][^0-9]*\([0-9][0-9]*\).*/\1/;s/\(.*[^0-9].*\)/0/' tmp.out`
      test x"$e" = x"$error" || exit 1
    fi

    case "$pos" in
    yes)
      if test -n "$VERBOSE" ; then
        $DIFFPOS tmp.3d $srcdir/$file.pos || exit 1
      else
        $DIFFPOS tmp.3d $srcdir/$file.pos > /dev/null || exit 1
      fi ;;
    no)
      test -f tmp.3d || exit 1 ;;
    fail)
      test -f tmp.3d && exit 1 ;;
    *)
      echo "Bad value for pos: '$pos'" ; exit 1 ;;
    esac
    rm -f tmp.*
  fi
done
test -n "$VERBOSE" && echo "Test passed"
exit 0
