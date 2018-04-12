Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeDLMBq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:01:46 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:51119 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752396AbeDLMBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:01:43 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:196:355:379:541:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2559:2563:2682:2685:2828:2829:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4552:5007:6117:6691:6742:9025:10004:10400:10848:11232:11658:11914:12043:12740:12760:12895:13069:13095:13181:13229:13255:13311:13357:13439:14040:14096:14097:14181:14659:14721:14777:14819:21080:21433:21627:30022:30054:30060:30062:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: need86_48b81f51c4c3d
X-Filterd-Recvd-Size: 2724
Message-ID: <a8677d8c351e4cb49907f9a8addcc261d810655a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
From: Joe Perches <joe@perches.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 12 Apr 2018 05:01:37 -0700
In-Reply-To: <20180412115022.GL4043@hirez.programming.kicks-ass.net>
References: <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
         <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
         <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
         <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
         <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
         <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
         <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
         <20180411170049.GR4082@hirez.programming.kicks-ass.net>
         <20180412074719.pmcddramzyikppco@gmail.com> <20180412093521.GA6427@andrea>
         <20180412115022.GL4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-12 at 13:50 +0200, Peter Zijlstra wrote:
> On Thu, Apr 12, 2018 at 11:35:21AM +0200, Andrea Parri wrote:
> > Is there a better or recommended way to reference posts on LKML in commit
> > messages? (I do like the idea of linking to previous discussions, results,
> > ...)
> 
> Yes:
> 
>   https://lkml.kernel.org/r/$MSGID
> 
> that has the added benefit that it immediately includes the msg-id, so
> even if you don't have tubes, you can search for it in your local
> mailboxes.
> 
> Also, since we (kernel.org) control the redirection (currently
> marc.info) we can always point it to a life archive.

Message IDs are not useful unless you subscribe and
keep your emails.

It'd be _much_ nicer if vger.kernel.org stored every email
it sent and had a search mechanism available rather than
relying on external systems.
