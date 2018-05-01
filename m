Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755681AbeEAN3o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:29:44 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:41147 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeEAN3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:29:43 -0400
X-Google-Smtp-Source: AB8JxZpy5SefoGn+f24lrq1iwkMVYLb+3T8fni7ZoZzFee7A+kv91yZMQrDgYfZ1w3V99NyeA6Xsqw==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Tue, 1 May 2018 09:29:38 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: perf: fuzzer causes stack going in wrong direction warnings
In-Reply-To: <20180111192112.d35nkotzklicd27c@treble>
Message-ID: <alpine.DEB.2.21.1805010925140.19413@macbook-air>
References: <20180109132602.GA2369@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1801090841300.15884@macbook-air> <20180109151253.GK6176@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1801091022040.16446@macbook-air> <20180109153341.GL6176@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1801091052010.16446@macbook-air> <20180109160551.GK3040@hirez.programming.kicks-ass.net> <20180109170716.bqmexpmywwr4bwuv@treble> <20180111052538.2qhj6oxnc24xumhk@treble> <alpine.DEB.2.21.1801111358580.22460@macbook-air>
 <20180111192112.d35nkotzklicd27c@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I reported this back in January, but I think it got lost since everyone 
was busy with other more pressing matters.

But in any case, the perf_fuzzer still can trigger these type of messages 
and just wanted to see if they were a cause for concern, or just noise.

[66620.496076] WARNING: can't dereference registers at 0000000051f78a40 for ip interrupt_entry+0xba/0xc0
[66620.506117] WARNING: stack recursion on stack type 4
[67126.898984] WARNING: stack going in the wrong direction? ip=native_sched_clock+0xd/0x90
[67148.214712] WARNING: can't dereference iret registers at 00000000c8f3c864 for ip error_exit+0x20/0x20


Vince
