Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCNLKC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:10:02 -0400
Received: from foss.arm.com ([217.140.101.70]:50826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbeCNLKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:10:00 -0400
Subject: Re: [PATCH v2 1/2] irqchip: stm32: Optimizes and cleans up stm32-exti
 irq_domain
To: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Ludovic BARRE <ludovic.barre@st.com>
References: <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <6491f248c6748f21a2acf310e186d2be4f9b4e4c.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <a709e416-4024-f804-b2ff-ae6c2171a7c8@arm.com>
Date: Wed, 14 Mar 2018 11:09:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802230938510.11168@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw,

On 23/02/18 08:42, Thomas Gleixner wrote:
> Radoslaw,
> 
> On Fri, 23 Feb 2018, Radoslaw Pietrzyk wrote:
> 
>> - discards setting handle_simple_irq handler for hierarchy interrupts
>> - removes acking in chained irq handler as this is done by
>> irq_chip itself inside handle_edge_irq
>> - removes unneeded irq_domain_ops.xlate callback
> 
> if that's all functionally correct, then this is a nice cleanup. Though
> from the above changelog its hard to tell because it merily tells WHAT the
> patch does, but not WHY. The WHY is the important information for a
> reviewer who is not familiar with the particular piece of code/hardware.
> 
> Can you please amend the changelog with proper explanations why a
> particular piece of code is not needed or has to be changed to something
> else?

Any update on this? I'd like to queue this for 4.17, but Thomas'
comments should be addressed before that happens. Ca you please respin a
version with a better change log and the various review tags?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
