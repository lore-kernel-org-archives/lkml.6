Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B8DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917F32089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917F32089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933692AbeGISS4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:18:56 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54788 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S932666AbeGISSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:18:54 -0400
Received: (qmail 9396 invoked by uid 2102); 9 Jul 2018 14:18:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jul 2018 14:18:53 -0400
Date:   Mon, 9 Jul 2018 14:18:53 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc:     Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <boqun.feng@gmail.com>,
        <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <npiggin@gmail.com>,
        <peterz@infradead.org>, <will.deacon@arm.com>, <dlustig@nvidia.com>
Subject: Re: LKMM patch scorecard for v4.19 merge window
In-Reply-To: <20180707001751.GA4336@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1807091418022.2462-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018, Paul E. McKenney wrote:

> Hello!
> 
> Here is the updated scorecard:
> 
> e9ff68680cd4 tools/memory-model: Add litmus test for full multicopy atomicity
> c21fcc6594f1 tools/memory-model: Fix ISA2+pooncelock+pooncelock+pombonce name
> 2f5a1b9b74a2 MAINTAINERS: Add Daniel Lustig as an LKMM reviewer
> e1c071fab8e1 locking/memory-barriers.txt/kokr: Update Korean translation to fix broken DMA vs. MMIO ordering example
> b95546bdac98 tools/memory-model: Remove ACCESS_ONCE() from recipes
> a1e5fd06bb6b tools/memory-model: Remove ACCESS_ONCE() from model
> a54df4f2be14 tools/memory-model: Make scripts executable
> c6b04f78bf25 docs: atomic_ops: Describe atomic_set as a write operation
> 36853a86cf04 tools/memory-model: Add informal LKMM documentation to MAINTAINERS
> 950ba9d5bb8f sched: Use smp_mb() in wake_woken_function()
> c7af75d2ba8b locking: Clarify requirements for smp_mb__after_spinlock()
> bc8209732066 doc: Update wake_up() & co. memory-barrier guarantees
> 
> 	All of these are ready for the upcoming merge window,
> 	thanks everyone!
> 
> 473fd6e42ddc tools/memory-model: Rename litmus tests to comply to norm7
> 
> 	This one still needs an ack.

I have audited this patch.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan

