Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE30C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADE120661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfB0JyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:54:18 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48253 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbfB0JyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:54:15 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gyvuk-0007vs-Py; Wed, 27 Feb 2019 10:54:10 +0100
Date:   Wed, 27 Feb 2019 10:54:10 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 11/32] softirq: Macrofy softirq vectors
Message-ID: <20190227095410.oq5wf7cjn7xblxea@linutronix.de>
References: <20190212171423.8308-1-frederic@kernel.org>
 <20190212171423.8308-12-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212171423.8308-12-frederic@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-12 18:14:02 [+0100], Frederic Weisbecker wrote:
> --- /dev/null
> +++ b/include/linux/softirq_vector.h
> @@ -0,0 +1,10 @@
could you please add a spdx header/identifier here?

> +SOFTIRQ_VECTOR(HI)
> +SOFTIRQ_VECTOR(TIMER)
> +SOFTIRQ_VECTOR(NET_TX)
> +SOFTIRQ_VECTOR(NET_RX)
> +SOFTIRQ_VECTOR(BLOCK)
> +SOFTIRQ_VECTOR(IRQ_POLL)
> +SOFTIRQ_VECTOR(TASKLET)
> +SOFTIRQ_VECTOR(SCHED)
> +SOFTIRQ_VECTOR(HRTIMER)
> +SOFTIRQ_VECTOR(RCU)    /* Preferable RCU should always be the last softirq */

Sebastian
