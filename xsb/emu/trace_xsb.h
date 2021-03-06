/* File:      trace_xsb.h
** Contact:   xsb-contact@cs.sunysb.edu
** 
** Copyright (C) The Research Foundation of SUNY, 1986, 1993-1999
** 
** XSB is free software; you can redistribute it and/or modify it under the
** terms of the GNU Library General Public License as published by the Free
** Software Foundation; either version 2 of the License, or (at your option)
** any later version.
** 
** XSB is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
** FOR A PARTICULAR PURPOSE.  See the GNU Library General Public License for
** more details.
** 
** You should have received a copy of the GNU Library General Public License
** along with XSB; if not, write to the Free Software Foundation,
** Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
**
** 
*/

#ifndef __TRACE_XSB_H__
#define __TRACE_XSB_H__

#include "basicdefs.h"
#include "basictypes.h"

struct trace_str {		/* for tracing purpose below */
    double time_count;
};

extern struct trace_str tds;

extern void total_stat(CTXTdeclc double);
extern void stat_inusememory(CTXTdeclc double,int);
extern void perproc_reset_stat(void), reset_stat_total(void); 

extern void perproc_stat(void); 

#endif /* __TRACE_XSB_H__ */
