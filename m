Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034035AbeBPOS0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:18:26 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56426 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033893AbeBPOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:18:25 -0500
Date: Fri, 16 Feb 2018 15:16:18 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Randy Dunlap <rdunlap@infradead.org>
cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: CONFIG_IRQ_TIMINGS?
In-Reply-To: <8ae9d59b-7499-87cd-702f-c722b9a77939@infradead.org>
Message-ID: <alpine.DEB.2.21.1802161515020.1294@nanos.tec.linutronix.de>
References: <8ae9d59b-7499-87cd-702f-c722b9a77939@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018, Randy Dunlap wrote:

> Hi,
> 
> Is this a dead kconfig symbol?  I don't see any Kconfig file that
> sets/enables it.
> 
> ./kernel/irq/Makefile:4:obj-$(CONFIG_IRQ_TIMINGS) += timings.o
> ./kernel/irq/internals.h:#ifdef CONFIG_IRQ_TIMINGS
> ./kernel/irq/internals.h:#endif /* CONFIG_IRQ_TIMINGS */
> ./include/linux/interrupt.h:#ifdef CONFIG_IRQ_TIMINGS

The actual use case is stil being worked on. Took a bit longer than
expected, but Daniel might have a more accurate answer.

Thanks,

	tglx
