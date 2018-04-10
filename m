Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeDJWAO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 18:00:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59676 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbeDJWAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:00:13 -0400
Date: Tue, 10 Apr 2018 15:00:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joe Perches <joe@perches.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
Message-Id: <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
In-Reply-To: <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
        <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
        <20180410123305.GF4082@hirez.programming.kicks-ass.net>
        <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
        <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
        <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
        <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 14:53:51 -0700 Joe Perches <joe@perches.com> wrote:

> On Tue, 2018-04-10 at 14:39 -0700, Andrew Morton wrote:
> > On Tue, 10 Apr 2018 11:19:54 -0700 Joe Perches <joe@perches.com> wrote:
> > 
> > > A struct with a bool member can have different sizes on various
> > > architectures because neither bool size nor alignment is standardized.
> > 
> > What's wrong with bools in structs?
> 
> See above.

Yeah, but so what?  `long' has different sizes on different
architectures too.
