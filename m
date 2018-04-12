Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeDLILj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 04:11:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55068 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbeDLILh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 04:11:37 -0400
Date: Thu, 12 Apr 2018 10:11:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
        Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
Message-ID: <20180412081110.GU4082@hirez.programming.kicks-ass.net>
References: <20180410123305.GF4082@hirez.programming.kicks-ass.net>
 <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
 <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
 <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
 <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
 <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
 <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
 <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
 <20180411170049.GR4082@hirez.programming.kicks-ass.net>
 <20180412074719.pmcddramzyikppco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412074719.pmcddramzyikppco@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 09:47:19AM +0200, Ingo Molnar wrote:
> lkml.org is nice in emails that have a short expected life time and relevance - 

I like lkml.org's archive (although it's not without its problems), but
the site suffers from serious availability issues -- it is down a lot,
which is _really_ tedious.
