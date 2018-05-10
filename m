Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757354AbeEJMtT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:49:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757217AbeEJMtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:49:18 -0400
Date: Thu, 10 May 2018 07:49:16 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH 1/2] x86/stacktrace: do not fail when regs on stack for
 ORC
Message-ID: <20180510124916.ckgjtgmmcy33ahtd@treble>
References: <20171130080325.24785-1-jslaby@suse.cz>
 <20171130195710.cu2lsa47kwnow2hi@treble>
 <73526a6b-5083-78f1-8f76-d5f3ac52f958@suse.cz>
 <20171218033749.ihpwkjh7qfnilj4s@treble>
 <20171220174544.g34v2lkjrz2r6kh7@treble>
 <bf832ed0-47f4-2e8c-f320-1f54bce76e5c@suse.cz>
 <20180416221653.bf3or5yarlame3co@treble>
 <20180419134222.truupyqhwcpnhuis@treble>
 <a27a7de0-cc28-cfc8-7d0b-7d284f5d5788@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a27a7de0-cc28-cfc8-7d0b-7d284f5d5788@suse.cz>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 02:33:03PM +0200, Jiri Slaby wrote:
> On 04/19/2018, 03:42 PM, Josh Poimboeuf wrote:
> > On Mon, Apr 16, 2018 at 05:16:53PM -0500, Josh Poimboeuf wrote:
> >> On Wed, Dec 20, 2017 at 08:07:17PM +0100, Jiri Slaby wrote:
> >>> On 12/20/2017, 06:45 PM, Josh Poimboeuf wrote:
> >>>> It might not be until 2018 though.  But in the meantime you can go ahead
> >>>> and update your patches accordingly and then we can combine them for
> >>>> testing next year.
> >>>
> >>> I already did ;). So when you have that ready, I will send it on top
> >>> right after.
> >>
> >> Sorry for the delay...  Here's a (lightly tested) patch.  Can you test
> >> it with the latest version of your patches?
> > 
> > This one actually compiles:
> > 
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > Subject: [PATCH] x86/unwind/orc: Detect the end of the stack
> 
> With this patch applied, livepatching never completes. Kthreads are in
> the unpatched state forever. I have no details yet.

Hm, I thought I had tested that, but now I'm not sure.  Let me try it
again.

-- 
Josh
