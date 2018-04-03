Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932175AbeDCMjN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:39:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932087AbeDCMjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:39:11 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180403093030.GB4082@hirez.programming.kicks-ass.net>
References: <20180403093030.GB4082@hirez.programming.kicks-ass.net> <20180403154122.00d76d61@canb.auug.org.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29148.1522759148.1@warthog.procyon.org.uk>
Date: Tue, 03 Apr 2018 13:39:08 +0100
Message-ID: <29149.1522759148@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> wrote:

> I figured that since there were only a handful of users it wasn't a
> popular API, also David very much knew of those patches changing it so
> could easily have pulled in the special tip/sched/wait branch :/

I'm not sure I could, since I have to base on net-next.  I'm not sure what
DaveM's policy on that is.

Also, it might've been better not to simply erase the atomic_t wait API
immediately, but substitute wrappers for it to be removed one iteration hence.

David
