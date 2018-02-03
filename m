Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeBCBIQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 20:08:16 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51047 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbeBCBIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 20:08:09 -0500
X-Google-Smtp-Source: AH8x226yAQgw0UmUeyx+XjBq2a+t00EhR0xDFTnkYDJ8fsjqIInCecWtL+kfRVS1pMkFyMOmKtIghg==
Date: Sat, 3 Feb 2018 02:08:00 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: corbet@lwn.net, stern@rowland.harvard.edu, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: list file memory-barriers.txt within
 the LKMM entry
Message-ID: <20180203010800.GA6570@andrea>
References: <1517562822-6293-1-git-send-email-parri.andrea@gmail.com>
 <20180202235102.GC3617@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202235102.GC3617@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 03:51:02PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 02, 2018 at 10:13:42AM +0100, Andrea Parri wrote:
> > Now that a formal specification of the LKMM has become available to
> > the developer, some concern about how to track changes to the model
> > on the level of the "high-level documentation" was raised.
> > 
> > A first "mitigation" to this issue, suggested by Will, is to assign
> > maintainership (and responsibility!!)  of such documentation (here,
> > memory-barriers.txt) to the maintainers of the LKMM themselves.
> > 
> > Suggested-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> 
> Very good, thank you, queued!  Please see below for the usual commit-log
> rework.  BTW, in future submissions, could you please capitalize the
> first word after the colon (":") in the subject line?  It is all too
> easy for me to forget to change this, as Ingo can attest.  ;-)

Sorry, I'll do my best! ;-)


> 
> If we are going to continue to use the LKMM acronym, should we make the
> first line of the MAINTAINERS block look something like this?

I've no strong opinion about whether we should, but it makes sense to me.
(The acronym is currently defined (and heavily used) in explanation.txt.)

Thanks,
  Andrea


> 
> 	LINUX KERNEL MEMORY CONSISTENCY MODEL (LKMM)
> 
> One alternative would be to start calling it LKMCM, though that does
> look a bit like a Roman numeral.  ;-)
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 2f80571625dc2d1977acdef79267ba1645b07c53
> Author: Andrea Parri <parri.andrea@gmail.com>
> Date:   Fri Feb 2 10:13:42 2018 +0100
> 
>     MAINTAINERS: List file memory-barriers.txt within the LKMM entry
>     
>     We now have a shiny new Linux-kernel memory model (LKMM) and the old
>     tried-and-true Documentation/memory-barrier.txt.  It would be good to
>     keep these automatically synchronized, but in the meantime we need at
>     least let people know that they are related.  Will suggested adding the
>     Documentation/memory-barrier.txt file to the LKMM maintainership list,
>     thus making the LKMM maintainers responsible for both the old and the new.
>     This commit follows Will's excellent suggestion.
>     
>     Suggested-by: Will Deacon <will.deacon@arm.com>
>     Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba4dc08fbe95..e6ad9b44e8fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8101,6 +8101,7 @@ L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>  F:	tools/memory-model/
> +F:	Documentation/memory-barriers.txt
>  
>  LINUX SECURITY MODULE (LSM) FRAMEWORK
>  M:	Chris Wright <chrisw@sous-sol.org>
> 
