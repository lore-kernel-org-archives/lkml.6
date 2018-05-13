Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeEMIlh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 04:41:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59439 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeEMIlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 04:41:36 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] Documentation/admin-guide/pm/intel_pstate: fix Active Mode w/o HWP paragraph
Date: Sun, 13 May 2018 10:41:05 +0200
Message-ID: <2012541.gp2fSrYHDl@aspire.rjw.lan>
In-Reply-To: <1525804604.49308.15.camel@linux.intel.com>
References: <20180508151209.9314-1-juri.lelli@redhat.com> <1525804604.49308.15.camel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 8, 2018 8:36:44 PM CEST Srinivas Pandruvada wrote:
> On Tue, 2018-05-08 at 17:12 +0200, Juri Lelli wrote:
> > P-state selection algorithm (powersave or performance) is selected by
> > echoing the desired choice to scaling_governor sysfs attribute and
> > not
> > to scaling_cur_freq (as currently stated).
> > 
> > Fix it.
> Thanks for the fix.
> 
> > 
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> 
> > 
> > ---
> >  Documentation/admin-guide/pm/intel_pstate.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/pm/intel_pstate.rst
> > b/Documentation/admin-guide/pm/intel_pstate.rst
> > index d2b6fda3d67b..ab2fe0eda1d7 100644
> > --- a/Documentation/admin-guide/pm/intel_pstate.rst
> > +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> > @@ -145,7 +145,7 @@ feature enabled.]
> >  
> >  In this mode ``intel_pstate`` registers utilization update callbacks
> > with the
> >  CPU scheduler in order to run a P-state selection algorithm, either
> > -``powersave`` or ``performance``, depending on the
> > ``scaling_cur_freq`` policy
> > +``powersave`` or ``performance``, depending on the
> > ``scaling_governor`` policy
> >  setting in ``sysfs``.  The current CPU frequency information to be
> > made
> >  available from the ``scaling_cur_freq`` policy attribute in
> > ``sysfs`` is
> >  periodically updated by those utilization update callbacks too.
> 

Applied and pushed for 4.17-rc5, thanks!
