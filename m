Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbeEWNBc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:01:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42524 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeEWNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:01:31 -0400
Date: Wed, 23 May 2018 15:01:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH v2 0/8] Introduce refcount_dec_and_lock_irqsave()
Message-ID: <20180523130125.GZ12217@hirez.programming.kicks-ass.net>
References: <20180509193645.830-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509193645.830-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 09:36:37PM +0200, Sebastian Andrzej Siewior wrote:
> This series is a v2 of the atomic_dec_and_lock_irqsave(). Now refcount_*
> is used instead of atomic_* as suggested by Peter Zijlstra.
> 
> Patch
> - 1-3 converts the user from atomic_* API to refcount_* API
> - 4 implements refcount_dec_and_lock_irqsave
> - 5-8 converts the local_irq_save() + refcount_dec_and_lock() users to
>   refcount_dec_and_lock_irqsave()
> 
> The whole series sits also at
>   git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git refcount_t_irqsave
> 

1-2, 4-6:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
