Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbeEAT7j (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 15:59:39 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:37733 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbeEAT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 15:59:37 -0400
X-Google-Smtp-Source: AB8JxZqgLQNDNK3e2PYHBLEWX3ivEa+VCX/C5ySIf8CikdFQTMQgzYKEVLQ4DIe+ZAEX8HWOBd7C3Q==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 1 May 2018 15:59:31 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: perf: fuzzer causes stack going in wrong direction warnings
In-Reply-To: <20180501135850.enx4waqd5d7yowlj@treble>
Message-ID: <alpine.DEB.2.21.1805011557240.19937@macbook-air>
References: <20180109151253.GK6176@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1801091022040.16446@macbook-air> <20180109153341.GL6176@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1801091052010.16446@macbook-air> <20180109160551.GK3040@hirez.programming.kicks-ass.net>
 <20180109170716.bqmexpmywwr4bwuv@treble> <20180111052538.2qhj6oxnc24xumhk@treble> <alpine.DEB.2.21.1801111358580.22460@macbook-air> <20180111192112.d35nkotzklicd27c@treble> <alpine.DEB.2.21.1805010925140.19413@macbook-air>
 <20180501135850.enx4waqd5d7yowlj@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2018, Josh Poimboeuf wrote:

> Can you try the following patch?

I applied the patch, but the warnings don't really look that different.

[   62.220322] WARNING: stack recursion on stack type 4
[   62.220326] WARNING: can't dereference registers at 000000009ca2e86d for ip swapgs_restore_regs_and_return_to_usermode+0x79/0x87
[  367.597013] WARNING: stack going in the wrong direction? ip=native_sched_clock+0x9/0x90

Vince
