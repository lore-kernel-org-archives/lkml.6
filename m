Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965411AbeEXIl2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:41:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48658 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965042AbeEXIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:41:24 -0400
Date: Thu, 24 May 2018 10:41:22 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched,tracing: Correct trace_sched_pi_setprio() for
 deboosting
Message-ID: <20180524084121.uzumbyixfnfikkky@linutronix.de>
References: <20180523141107.6417-1-bigeasy@linutronix.de>
 <20180523172819.GW12198@hirez.programming.kicks-ass.net>
 <20180524074413.dukslrbgqfvaab5b@linutronix.de>
 <20180524083754.GD12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524083754.GD12198@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-24 10:37:54 [+0200], Peter Zijlstra wrote:
> Thing is, with the pi_task as an argument, someone using the tracehook
> can actually get the deadline data out, even if the normal 'event' does
> not.

Okay, in that case an update will follow shortly.

Sebastian
