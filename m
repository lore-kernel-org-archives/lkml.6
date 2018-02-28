Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeB1CyB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:54:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:30136 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751611AbeB1CyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:54:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,403,1515484800";
   d="scan'208";a="204280236"
Date: Wed, 28 Feb 2018 10:45:02 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Du, Changbin" <changbin.du@intel.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] tracing/power: Polish the tracepoints cpu_idle and
 cpu_frequency
Message-ID: <20180228024502.6kgudpsvx7hvlvcn@intel.com>
References: <1518576038-16198-1-git-send-email-changbin.du@intel.com>
 <20180214095440.2debdbba@gandalf.local.home>
 <20180227093526.z7gxg2nk7xmfk2oi@intel.com>
 <20180227173938.0826ed9b@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227173938.0826ed9b@vmware.local.home>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 05:39:38PM -0500, Steven Rostedt wrote:
> On Tue, 27 Feb 2018 17:35:27 +0800
> "Du, Changbin" <changbin.du@intel.com> wrote:
> 
> > > From the tracing perspective:
> > > 
> > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > 
> > > -- Steve
> > >  
> > Hi Steve, will you pick this or someoneelse?
> 
> I maintain the tracing infrastructure, but the tracing use cases are
> maintained by the maintainers of the users of the trace events. That
> is, who added these trace events? They are the ones most affected by
> these changes.
> 
> For example, it looks like Rafael J. Wysocki, is the one that added
> trace_cpu_frequency(). He's the one that is affected by this change,
> and is the one that you need to have take it.
>
Got it, thanks!

Hi Wysocki, could you take a look?

> -- Steve
> 

-- 
Thanks,
Changbin Du
