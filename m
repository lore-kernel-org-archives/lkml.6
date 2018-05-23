Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932906AbeEWNJo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:09:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44120 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932707AbeEWNJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:09:40 -0400
Date: Wed, 23 May 2018 15:09:27 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH v2 0/8] Introduce refcount_dec_and_lock_irqsave()
Message-ID: <20180523130927.qhblygmszkp4iwne@linutronix.de>
References: <20180509193645.830-1-bigeasy@linutronix.de>
 <20180523130125.GZ12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523130125.GZ12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-23 15:01:25 [+0200], Peter Zijlstra wrote:
> 1-2, 4-6:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thank you.

Sebastian
