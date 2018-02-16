Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757746AbeBPJQL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:16:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:10983 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757726AbeBPJQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:16:09 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="27756849"
Date: Fri, 16 Feb 2018 17:07:26 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, corbet@lwn.net, mingo@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Documentation: convert trace/ftrace-design.txt to
 rst format
Message-ID: <20180216090726.hcwaq6zxa65c4pk5@intel.com>
References: <1518750739-12514-1-git-send-email-changbin.du@intel.com>
 <1518750739-12514-3-git-send-email-changbin.du@intel.com>
 <20180215225705.58984492@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215225705.58984492@vmware.local.home>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 10:57:05PM -0500, Steven Rostedt wrote:
> On Fri, 16 Feb 2018 11:12:18 +0800
> changbin.du@intel.com wrote:
> 
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > ---
> >  .../trace/{ftrace-design.txt => ftrace-design.rst} | 248 +++++++++++----------
> >  Documentation/trace/index.rst                      |   2 +
> >  2 files changed, 137 insertions(+), 113 deletions(-)
> >  rename Documentation/trace/{ftrace-design.txt => ftrace-design.rst} (75%)
> > 
> > diff --git a/Documentation/trace/ftrace-design.txt b/Documentation/trace/ftrace-design.rst
> > similarity index 75%
> > rename from Documentation/trace/ftrace-design.txt
> > rename to Documentation/trace/ftrace-design.rst
> > index a273dd0..0f32a85 100644
> > --- a/Documentation/trace/ftrace-design.txt
> > +++ b/Documentation/trace/ftrace-design.rst
> > @@ -1,6 +1,8 @@
> > -		function tracer guts
> > -		====================
> > -		By Mike Frysinger
> > +======================
> > +Function Tracer Design
> > +======================
> > +
> > +:Author: Mike Frysinger
> >  
> 
> This document is out of date, and I rather have it updated before we
> make it more "available" elsewhere.
>
Got you. I plan to convert below docs. Are they out of date, too?

events-msr.txt, events.txt, mmiotrace.txt, stm.txt, uprobetracer.txt
events-nmi.txt, intel_th.txt, tracepoint-analysis.txt, events-kmem.txt,
events-power.txt, ftrace.txt, hwlat_detector.txt, kprobetrace.txt,
tracepoints.txt.
 
> -- Steve

-- 
Thanks,
Changbin Du
