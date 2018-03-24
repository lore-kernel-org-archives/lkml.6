Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeCXIP6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 04:15:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53869 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCXIPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 04:15:54 -0400
X-Google-Smtp-Source: AIpwx49Da5vu6zpv2ZUIjGjLnKecNz9lmQ/9w2HYVfNXy5xGyCHq9JZKgdYFLIYokh4unfTy/U1/sg==
Date: Sat, 24 Mar 2018 09:15:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: linux-next: manual merge of the tip tree with the pm tree
Message-ID: <20180324081549.lqqh6w65d4mfyax5@gmail.com>
References: <20180323132001.7da7f3c4@canb.auug.org.au>
 <20180323060924.jeppeix62c3wza6l@gmail.com>
 <6072268.CPFKWgAbKZ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6072268.CPFKWgAbKZ@aspire.rjw.lan>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> On Friday, March 23, 2018 7:09:24 AM CET Ingo Molnar wrote:
> > 
> > * Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > > Hi all,
> > > 
> > > Today's linux-next merge of the tip tree got a conflict in:
> > > 
> > >   kernel/sched/cpufreq_schedutil.c
> > > 
> > > between commit:
> > > 
> > >   0953feed3400 ("cpufreq: schedutil: rate limits for SCHED_DEADLINE")
> > 
> > Rafael, could you please send that to the scheduler tree?
> 
> You can apply from
> 
> https://patchwork.kernel.org/patch/10278127/
> 
> and I will drop it from my tree.
> 
> Thanks!

Great - Thomas picked it up and it's now in tip:sched/core:

  e97a90f7069b: sched/cpufreq: Rate limits for SCHED_DEADLINE

and it should hit -next on Monday.

Thanks,

	Ingo
