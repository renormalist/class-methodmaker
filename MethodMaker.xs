#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

MODULE = Class::MethodMaker PACKAGE = Class::MethodMaker

int
set_sub_name(SV *sub, char *pname, char *subname, char *stashname)
  INIT:
    if (!SvTRUE(ST(0)) || !SvTRUE(ST(1)) || !SvTRUE(ST(2)) || !SvTRUE(ST(3)))
      XSRETURN_UNDEF;
  CODE:
    CvGV((GV*)SvRV(sub)) = gv_fetchpv(stashname, TRUE, SVt_PV);
    GvSTASH(CvGV((GV*)SvRV(sub))) = gv_stashpv(pname, 1);
#ifdef gv_name_set
    gv_name_set(CvGV((GV*)SvRV(sub)), subname, strlen(subname), GV_NOTQUAL);
#else
    GvNAME(CvGV((GV*)SvRV(sub))) = savepv(subname);
    GvNAMELEN(CvGV((GV*)SvRV(sub))) = strlen(subname);
#endif
    RETVAL = 1;
