Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162460AbeBPRvg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:51:36 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56668 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162430AbeBPRvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:51:35 -0500
Subject: Re: CONFIG_IRQ_TIMINGS?
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
References: <8ae9d59b-7499-87cd-702f-c722b9a77939@infradead.org>
 <alpine.DEB.2.21.1802161515020.1294@nanos.tec.linutronix.de>
 <fc5ade5c-dc68-a85e-6a1f-db8ece573fac@linaro.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <80739d7b-b035-05ca-9649-a26f0173eca1@infradead.org>
Date: Fri, 16 Feb 2018 09:51:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <fc5ade5c-dc68-a85e-6a1f-db8ece573fac@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/2018 06:54 AM, Daniel Lezcano wrote:
> On 16/02/2018 15:16, Thomas Gleixner wrote:
>> On Thu, 15 Feb 2018, Randy Dunlap wrote:
>>
>>> Hi,
>>>
>>> Is this a dead kconfig symbol?  I don't see any Kconfig file that
>>> sets/enables it.
>>>
>>> ./kernel/irq/Makefile:4:obj-$(CONFIG_IRQ_TIMINGS) += timings.o
>>> ./kernel/irq/internals.h:#ifdef CONFIG_IRQ_TIMINGS
>>> ./kernel/irq/internals.h:#endif /* CONFIG_IRQ_TIMINGS */
>>> ./include/linux/interrupt.h:#ifdef CONFIG_IRQ_TIMINGS
> 
> This feature is not supposed to be selected by the user but by a
> subsystem depending on it. This subsystems is not yet ready, this is why
> the option is not selectable for now.
> 
> The algorithm using these timings appears to be too heavy for the
> kernel, it needs some rework.

OK, thanks for the info.

-- 
~Randy
