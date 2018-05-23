Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932923AbeEWNCt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:02:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbeEWNCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:02:46 -0400
Date: Wed, 23 May 2018 15:02:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Subject: Re: Introduce atomic_dec_and_lock_irqsave()
Message-ID: <20180523130241.GA12217@hirez.programming.kicks-ass.net>
References: <20180504154533.8833-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504154533.8833-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 05:45:28PM +0200, Sebastian Andrzej Siewior wrote:
> This series introduces atomic_dec_and_lock_irqsave() and converts a few
> users to use it. They were using local_irq_save() +
> atomic_dec_and_lock() before that series.

1,5-6:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
