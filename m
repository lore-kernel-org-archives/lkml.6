Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426757AbeBOQ6W convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:58:22 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423530AbeBOQ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:58:17 -0500
Date: Thu, 15 Feb 2018 17:58:10 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Levin Alexander <alexander.levin@verizon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Abeni <pabeni@redhat.com>, Radu Rendec <rrendec@arista.com>,
        Ingo Molnar <mingo@kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Rik van Riel <riel@redhat.com>, Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 2/4] softirq: Per vector deferment to workqueue
Message-ID: <20180215165809.mjmzmwxxd63mmuf4@linutronix.de>
References: <1516376774-24076-1-git-send-email-frederic@kernel.org>
 <1516376774-24076-3-git-send-email-frederic@kernel.org>
 <20180208174450.qjvjy752jf4ngt2g@breakpoint.cc>
 <20180215161349.GA6956@lerouge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180215161349.GA6956@lerouge>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-15 17:13:52 [+0100], Frederic Weisbecker wrote:
> Yeah that makes sense. These workqueues are too much headaches eventually.
> I'm going to try that ksoftirqd thing.

I may have something for that USB problem, I just need some testing
before posting…

> Thanks.

Sebastian
