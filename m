Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeDJVx5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:53:57 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:37948 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751918AbeDJVx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:53:56 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3870:3871:3876:4321:5007:6742:8603:10004:10400:10848:10967:11232:11658:11914:12740:12760:12895:13069:13255:13311:13357:13439:14181:14659:14721:21080:21627:30054:30060:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: jail24_21f0f737fce2f
X-Filterd-Recvd-Size: 1889
Message-ID: <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 10 Apr 2018 14:53:51 -0700
In-Reply-To: <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
         <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
         <20180410123305.GF4082@hirez.programming.kicks-ass.net>
         <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
         <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
         <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 14:39 -0700, Andrew Morton wrote:
> On Tue, 10 Apr 2018 11:19:54 -0700 Joe Perches <joe@perches.com> wrote:
> 
> > A struct with a bool member can have different sizes on various
> > architectures because neither bool size nor alignment is standardized.
> 
> What's wrong with bools in structs?

See above.
