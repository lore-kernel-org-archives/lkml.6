Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbeBLSRh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:17:37 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53930 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeBLSRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:17:35 -0500
X-Google-Smtp-Source: AH8x227ZCeKlBSHDgYBOiSztvkm7Nam/gJN3y9749w5hjQJLCcJFIQy2UBdzJ8zwXTgxzQwxUCoyzQ==
Date: Mon, 12 Feb 2018 19:17:31 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, vincent.guittot@linaro.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, alessio.balsini@arm.com
Subject: Re: [RFC PATCH 1/3] sched/deadline: merge dl_bw into dl_bandwidth
Message-ID: <20180212181731.GO12979@localhost.localdomain>
References: <20180212134030.12846-1-juri.lelli@redhat.com>
 <20180212134030.12846-2-juri.lelli@redhat.com>
 <20180212123430.6f8e4d6e@gandalf.local.home>
 <20180212174312.GN12979@localhost.localdomain>
 <20180212130239.506cbce9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212130239.506cbce9@gandalf.local.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/18 13:02, Steven Rostedt wrote:
> On Mon, 12 Feb 2018 18:43:12 +0100
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > However, this surely needs to be fixed here. It's tracking the sum of
> > all tasks' (across CPUs) bandwidth admitted on the system, so that's why
> > it's called dl_total_bw. Incremented when a task passes sched_setattr()
> > and decremented when it leaves the system or changes scheduling class.
> > 
> > Does it make a bit more sense? Would you still prefer a different name?
> 
> No the name is fine, the comment needs to change.
> 
>  - dl_total_bw - tracks the sum of all tasks' bandwidth across CPUs.
> 
> How's that?

LGTM. I'll fix in next version.

Thanks!

- Juri
