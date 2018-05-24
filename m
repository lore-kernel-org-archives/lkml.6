Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967434AbeEXMx3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:53:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964863AbeEXMx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:53:28 -0400
Date: Thu, 24 May 2018 14:53:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 85f1abe001 ("kthread, sched/wait: Fix kthread_parkme() .."):
 WARNING: CPU: 0 PID: 1 at kernel/kthread.c:486 kthread_park
Message-ID: <20180524125325.GG12198@hirez.programming.kicks-ass.net>
References: <alpine.LRH.2.21.1805241540010.17544@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1805241540010.17544@math.ut.ee>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 03:42:42PM +0300, Meelis Roos wrote:
> I had the same kthread_parkme warning on many machines I tested with 
> 4.17.0-rc6-00158-gbee797529d7c (x86, amd64, sparc, parisc, alpha).
> 
> Your patch https://lkml.org/lkml/2018/5/4/212 fixed the problem for me.
> 
> Sorry for off-thread respnse, I found your mail from the web only.

N/p and thanks for testing. Let me queue that patch before I loose sight
of it again.
