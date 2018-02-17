Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbeBQDjd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 22:39:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:21503 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750942AbeBQDjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 22:39:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,522,1511856000";
   d="scan'208";a="18372791"
Date: Sat, 17 Feb 2018 11:30:48 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, changbin.du@intel.com,
        mingo@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Documentation: convert trace/ftrace-design.txt to
 rst format
Message-ID: <20180217033047.nubl47hevaag5m3r@intel.com>
References: <1518750739-12514-1-git-send-email-changbin.du@intel.com>
 <1518750739-12514-3-git-send-email-changbin.du@intel.com>
 <20180215225705.58984492@vmware.local.home>
 <20180216054952.78718f09@lwn.net>
 <20180216123629.5ac2b373@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216123629.5ac2b373@gandalf.local.home>
User-Agent: NeoMutt/20171027-42-ad8712
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 12:36:29PM -0500, Steven Rostedt wrote:
> On Fri, 16 Feb 2018 05:49:52 -0700
> Jonathan Corbet <corbet@lwn.net> wrote:
> 
> > On Thu, 15 Feb 2018 22:57:05 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > This document is out of date, and I rather have it updated before we
> > > make it more "available" elsewhere.  
> > 
> > Imagine that, an out-of-date doc in the kernel :)
> > 
> > Seriously, though, I'd argue that (1) it's already highly available, and
> > (2) it's useful now.  And (3) who knows when that update will happen?
> > Unless we have reason to believe that a new version is waiting on the
> > wings, I don't really see why we would want to delay this work.
> 
> Actually, some of these documents I was thinking of labeling as
> "obsolete" or simply removing them. The ftrace-design one is about
> how to port ftrace to other architectures, and I already had to correct
> people that based their work on it.
> 
> Yeah, I really need to get some time to update them, but like everyone
> else, that's just the 90th thing I have to do.
> 
> -- Steve
Reading this doc, I think most of information are still useful for undertading the
implemeation. So how abount just put a caution at the begining of doc as below 
defore get updated?
http://docservice.askxiong.com/linux-kernel/trace/ftrace-design.html

Anyway, I just converted them all. I will send them out. Please comemnt if some
of them should be removed. 

-- 
Thanks,
Changbin Du
